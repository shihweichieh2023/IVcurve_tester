// iv_features_v2.js  (reads from iv_curve dict)
// Reads the "body" field from the "iv_curve" dictionary in Max
// Body format: "V1 I1, V2 I2, V3 I3, ... Vn In" (comma-separated pairs)
// Outlets:
// 0) F_ohmic   = [FF, Vmpp/Voc, Impp/Isc, Rs, Rsh, curvature_sum, area]
// 1) basics    = [Voc, Isc, Vmpp, Impp]
// 2) normCurve = [Vn0, In0, Vn1, In1, ...]  (64-point resampled)
// 3) F_dimless = [FF, Vmpp/Voc, Impp/Isc, r_s, r_sh, curvature_sum, area]

autowatch = 1;
inlets = 1;
outlets = 4;

var V = [];
var I = [];
var dictName = "iv_curve";

function clear(){ 
  V = []; 
  I = []; 
}

// Main function to read from iv_curve dictionary and process
function bang() {
  post("=== BANG received! Starting processing ===\n");
  
  // Read from the iv_curve dictionary
  var d = new Dict(dictName);
  post("Trying to read from dictionary: " + dictName + "\n");
  
  if (!d.contains("body")) {
    post("ERROR: Dictionary '" + dictName + "' missing key 'body'\n");
    post("Available keys in dictionary:\n");
    var keys = d.getkeys();
    if (keys) {
      for (var i = 0; i < keys.length; i++) {
        post("  - " + keys[i] + "\n");
      }
    }
    return;
  }
  
  var bodyStr = d.get("body");
  post("SUCCESS: Reading body: " + bodyStr + "\n");
  
  // Parse the comma-separated voltage-current pairs
  parseBodyString(bodyStr);
}

// Parse the body string containing comma-separated V-I pairs
function parseBodyString(bodyStr) {
  // Replace all commas with spaces
  var cleanStr = bodyStr.replace(/,/g, ' ');
  
  // Extract all numbers using regex
  var matches = cleanStr.match(/([+-]?\d*\.?\d+)/g);
  
  if (!matches || matches.length < 8 || (matches.length % 2) !== 0) {
    post("iv_features: body string needs even-length list with >=4 pairs\n");
    post("Found: " + (matches ? matches.length : 0) + " numbers\n");
    return;
  }
  
  // Process the voltage-current pairs
  V = []; I = [];
  for (var k = 0; k < matches.length; k += 2) {
    var v = parseFloat(matches[k]);
    var i = parseFloat(matches[k + 1]);
    
    if (!isFinite(v) || !isFinite(i)) {
      post("iv_features: non-finite @ pair " + (k/2) + "\n");
      continue;
    }
    
    V.push(v);
    I.push(i);
  }
  
  if (V.length < 4) {
    post("iv_features: <4 valid pairs after filtering\n");
    return;
  }
  
  post("Successfully parsed " + V.length + " V-I pairs from body\n");
  compute_and_output();
}

// Set dictionary name (optional - defaults to "iv_curve")
function dictionary(name) { 
  dictName = name; 
  post("Dictionary name set to: " + dictName + "\n");
}

function compute_and_output(){
  // sort by V
  var pairs=[]; for (var k=0;k<V.length;k++) pairs.push({V:V[k], I:I[k]});
  pairs.sort(function(a,b){return a.V-b.V;});
  V=[]; I=[]; for (var k2=0;k2<pairs.length;k2++){ V.push(pairs[k2].V); I.push(pairs[k2].I); }

  var Voc = vmax(V), Isc = vmax(I);
  if (!(isFinite(Voc)&&isFinite(Isc)) || Voc<=0 || Isc<=0){ post("iv_features: invalid Voc/Isc\n"); return; }

  // MPP / FF
  var P=[], mpp=0, Pm=P[0]=V[0]*I[0];
  for (var t=1;t<V.length;t++){ var p=V[t]*I[t]; P.push(p); if (p>Pm){Pm=p; mpp=t;} }
  var Vmpp=V[mpp], Impp=I[mpp], FF=(Vmpp*Impp)/(Voc*Isc);

  // normalized arrays
  var Vn=[], In=[]; for (var j=0;j<V.length;j++){ Vn.push(V[j]/Voc); In.push(I[j]/Isc); }

  // Rs near Voc (small In), Rsh near Isc (low Vn)
  var near=[], low=[];
  for (var j2=0;j2<In.length;j2++) if (In[j2]<0.1) near.push(j2);
  if (near.length<3) near=[In.length-3, In.length-2, In.length-1];
  for (var j3=0;j3<Vn.length;j3++) if (Vn[j3]<0.1) low.push(j3);
  if (low.length<3) low=[0,1,2];

  var dVdI_voc = lin_slope(I,V,near);  var Rs = -(dVdI_voc);
  var dVdI_isc = lin_slope(I,V,low);   var Rsh= -(dVdI_isc);

  var scale = Isc/Voc;
  var rs = scale*(-dVdI_voc);
  var rsh= scale*(-dVdI_isc);

  if(!isFinite(Rs)) Rs=0; if(!isFinite(Rsh)) Rsh=0;
  if(!isFinite(rs)) rs=0; if(!isFinite(rsh)) rsh=0;

  // curvature / area (64)
  var VN = linspace(0,1,64);
  var INu= interp1(Vn,In,VN);
  var second = second_diff(INu);
  var curv=0; for (var s=0;s<second.length;s++) curv+=Math.abs(second[s]);
  var area = trapz(VN,INu);

  outlet(0, [FF, Vmpp/Voc, Impp/Isc, Rs, Rsh, curv, area]);
  outlet(1, [Voc, Isc, Vmpp, Impp]);

  var flat=[]; for (var q=0;q<VN.length;q++){ flat.push(VN[q]); flat.push(INu[q]); }
  outlet(2, flat);

  outlet(3, [FF, Vmpp/Voc, Impp/Isc, rs, rsh, curv, area]);
}

// helpers
function vmax(a){ var m=a[0]; for (var i=1;i<a.length;i++) if (a[i]>m) m=a[i]; return m; }
function lin_slope(xarr,yarr,idxs){
  var n=idxs.length, sx=0,sy=0,sxx=0,sxy=0;
  for (var i=0;i<n;i++){ var x=xarr[idxs[i]], y=yarr[idxs[i]]; sx+=x; sy+=y; sxx+=x*x; sxy+=x*y; }
  var den=n*sxx - sx*sx; if (Math.abs(den)<1e-12) return 0.0;
  return (n*sxy - sx*sy)/den;
}
function linspace(a,b,n){ var out=[]; if(n<=1){out.push(a);return out;} var step=(b-a)/(n-1); for(var i=0;i<n;i++) out.push(a+i*step); return out; }
function interp1(x,y,xi){
  var yi=[], j=0;
  for (var i=0;i<xi.length;i++){ var xv=xi[i];
    while (j<x.length-2 && xv>x[j+1]) j++;
    var x0=x[j], x1=x[j+1], y0=y[j], y1=y[j+1];
    yi.push(x1==x0 ? y0 : y0 + (xv-x0)*(y1-y0)/(x1-x0));
  }
  return yi;
}
function second_diff(a){ var out=[]; for (var i=0;i<a.length-2;i++) out.push(a[i+2]-2*a[i+1]+a[i]); return out; }
function trapz(x,y){ var s=0; for (var i=0;i<x.length-1;i++) s+=0.5*(x[i+1]-x[i])*(y[i]+y[i+1]); return s; }
