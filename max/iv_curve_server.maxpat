{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 8,
			"minor" : 6,
			"revision" : 5,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 639.0, 88.0, 977.0, 867.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"assistshowspatchername" : 0,
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-52",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 758.0, 77.333340167999268, 69.0, 20.0 ],
					"text" : "/power.txt"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-45",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 629.0, 369.333340167999268, 39.0, 22.0 ],
					"text" : "dump"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-44",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 90.666669368743896, 364.000010848045349, 39.0, 22.0 ],
					"text" : "dump"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-42",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 421.0, 50.0, 144.0, 20.0 ],
					"text" : "get request to the server"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-41",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 422.0, 109.0, 84.0, 20.0 ],
					"text" : "output strings"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-37",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 580.0, 18.333340167999268, 260.0, 20.0 ],
					"text" : "ivcurve.local → maxurl (update every 500ms)"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-20",
					"maxclass" : "multislider",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 590.0, 905.333340167999268, 344.0, 129.0 ],
					"size" : 128
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-18",
					"linecount" : 4,
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 642.0, 711.333340167999268, 415.0, 60.0 ],
					"text" : "// 0) F_ohmic   = [FF, Vmpp/Voc, Impp/Isc, Rs, Rsh, curvature_sum, area]\n// 1) basics    = [Voc, Isc, Vmpp, Impp]\n// 2) normCurve = [Vn0, In0, Vn1, In1, ...]  (64-point resampled)\n// 3) F_dimless = [FF, Vmpp/Voc, Impp/Isc, r_s, r_sh, curvature_sum, area]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-4",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 590.0, 711.333340167999268, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-8",
					"linecount" : 2,
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 586.0, 1043.333340167999268, 321.0, 35.0 ],
					"text" : "0.244477 0.548673 0.445578 1.028607 0.776463 0.162506 0.498635"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-12",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 590.0, 863.333340167999268, 153.0, 22.0 ],
					"text" : "1017 0.294 558 0.131"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-14",
					"linecount" : 2,
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 590.0, 815.333340167999268, 327.0, 35.0 ],
					"text" : "0.913735 0.913735 1 -0.47122 0.079219 0.579937 0.428628"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-15",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 4,
					"outlettype" : [ "", "", "", "" ],
					"patching_rect" : [ 590.0, 781.333340167999268, 114.0, 22.0 ],
					"saved_object_attributes" : 					{
						"filename" : "iv_finger_prints.js",
						"parameter_enable" : 0
					}
,
					"text" : "js iv_finger_prints.js"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-21",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 580.0, 76.333340167999268, 176.0, 22.0 ],
					"text" : "get http://ivcurve.local/power.txt"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-24",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 758.0, 50.333340167999268, 69.0, 20.0 ],
					"text" : "/iv.csv"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-25",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 589.0, 369.333340167999268, 35.0, 22.0 ],
					"text" : "clear"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-26",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 833.0, 601.333340167999268, 32.0, 22.0 ],
					"text" : "print"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-27",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 571.0, 603.333340167999268, 18.0, 20.0 ],
					"text" : "0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-28",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 547.0, 405.333340167999268, 42.0, 20.0 ],
					"text" : "40mA"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-29",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 961.0, 603.333340167999268, 58.0, 20.0 ],
					"text" : "1600mV"
				}

			}
, 			{
				"box" : 				{
					"addpoints" : [ 6.0, 0.353, 0, 6.0, 0.353, 0, 7.0, 0.412, 0, 10.0, 0.345, 0, 10.0, 0.345, 0, 11.0, 0.379, 0, 16.0, 0.327, 0, 16.0, 0.327, 0, 18.0, 0.367, 0, 25.0, 0.325, 0, 25.0, 0.325, 0, 29.0, 0.377, 0, 33.0, 0.327, 0, 33.0, 0.327, 0, 38.0, 0.376, 0, 48.0, 0.324, 0, 48.0, 0.324, 0, 55.0, 0.372, 0, 69.0, 0.317, 0, 69.0, 0.317, 0, 79.0, 0.362, 0, 99.0, 0.304, 0, 99.0, 0.304, 0, 114.0, 0.35, 0, 135.0, 0.29, 0, 135.0, 0.29, 0, 156.0, 0.335, 0, 199.0, 0.27, 0, 199.0, 0.27, 0, 230.0, 0.312, 0, 251.0, 0.254, 0, 251.0, 0.254, 0, 290.0, 0.294, 0, 426.0, 0.197, 0, 426.0, 0.197, 0, 493.0, 0.228, 0, 599.0, 0.141, 0, 599.0, 0.141, 0, 698.0, 0.164, 0, 750.0, 0.092, 0, 750.0, 0.092, 0, 881.0, 0.108, 0, 896.0, 0.045, 0, 896.0, 0.045, 0, 1035.0, 0.001, 0, 1035.0, 0.001, 0, 1063.0, 0.054, 0, 1242.0, 0.001, 0 ],
					"classic_curve" : 1,
					"domain" : 1600.0,
					"grid" : 3,
					"gridcolor" : [ 0.313725490196078, 0.309803921568627, 0.309803921568627, 1.0 ],
					"gridstep_y" : 10.0,
					"id" : "obj-30",
					"maxclass" : "function",
					"numinlets" : 1,
					"numoutlets" : 4,
					"outlettype" : [ "float", "", "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 589.0, 405.333340167999268, 384.0, 192.0 ],
					"range" : [ 0.0, 40.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-31",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 510.0, 108.0, 55.0, 22.0 ],
					"text" : "get body"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-33",
					"linecount" : 2,
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 589.0, 301.333340167999268, 384.000011444091797, 35.0 ],
					"text" : "1.04, 37.44, 60.916, 70.985, 66.667, 48.101, 40.087, 28.876, 21.644, 15.431, 10.811, 7.218, 5.727, 3.449, 2.207, 1.471"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-34",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 595.0, 193.333340167999268, 65.0, 22.0 ],
					"text" : "route body"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-35",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 595.0, 229.333340167999268, 61.0, 22.0 ],
					"text" : "sprintf %s"
				}

			}
, 			{
				"box" : 				{
					"id" : "msgurl",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 580.0, 49.333340167999268, 157.0, 22.0 ],
					"text" : "get http://ivcurve.local/iv.csv"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-36",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "dictionary", "" ],
					"patching_rect" : [ 580.0, 108.333340167999268, 45.0, 22.0 ],
					"text" : "maxurl"
				}

			}
, 			{
				"box" : 				{
					"id" : "url",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "dictionary", "" ],
					"patching_rect" : [ 580.0, 108.333340167999268, 45.0, 22.0 ],
					"text" : "maxurl"
				}

			}
, 			{
				"box" : 				{
					"id" : "getbody",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "dictionary", "", "", "", "" ],
					"patching_rect" : [ 580.0, 157.333340167999268, 75.0, 22.0 ],
					"saved_object_attributes" : 					{
						"embed" : 0,
						"legacy" : 0,
						"parameter_enable" : 0,
						"parameter_mappable" : 0
					}
,
					"text" : "dict iv_curve"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-98",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 290.666675329208374, 612.000018239021301, 32.0, 22.0 ],
					"text" : "print"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-92",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 28.000000834465027, 609.333351492881775, 18.0, 20.0 ],
					"text" : "0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-91",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 4.00000011920929, 405.333345413208008, 42.0, 20.0 ],
					"text" : "40mA"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-90",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 418.66667914390564, 609.333351492881775, 58.0, 20.0 ],
					"text" : "1600mV"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-88",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 48.000001430511475, 364.000010848045349, 35.0, 22.0 ],
					"text" : "clear"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-86",
					"linecount" : 3,
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 48.000001430511475, 301.333342313766479, 384.0, 49.0 ],
					"text" : "1015 0.,, 877 0.04,, 733 0.09,, 584 0.14,, 415 0.19,, 244 0.25,, 193 0.26,, 131 0.28,, 96 0.29,, 66 0.3,, 46 0.31,, 32 0.32,, 24 0.31,, 15 0.31,, 9 0.31,, 5 0.29"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-83",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 47.5, 265.333341240882874, 43.0, 22.0 ],
					"text" : "zl lace"
				}

			}
, 			{
				"box" : 				{
					"classic_curve" : 1,
					"domain" : 1600.0,
					"grid" : 3,
					"gridcolor" : [ 0.313725490196078, 0.309803921568627, 0.309803921568627, 1.0 ],
					"gridstep_y" : 10.0,
					"id" : "obj-81",
					"maxclass" : "function",
					"numinlets" : 1,
					"numoutlets" : 4,
					"outlettype" : [ "float", "", "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 48.000001430511475, 405.333345413208008, 384.0, 192.0 ],
					"range" : [ 0.0, 40.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-79",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 47.5, 193.333339095115662, 65.0, 22.0 ],
					"text" : "route body"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-80",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 47.5, 229.333340167999268, 61.0, 22.0 ],
					"text" : "sprintf %s"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-69",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"patching_rect" : [ 147.0, 193.333340167999268, 65.0, 22.0 ],
					"text" : "route body"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-68",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 147.0, 229.333340167999268, 61.0, 22.0 ],
					"text" : "sprintf %s"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-65",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 319.0, 108.0, 55.0, 22.0 ],
					"text" : "get body"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-32",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "dictionary", "", "", "", "" ],
					"patching_rect" : [ 136.0, 157.333340167999268, 61.0, 22.0 ],
					"saved_object_attributes" : 					{
						"embed" : 0,
						"legacy" : 0,
						"parameter_enable" : 0,
						"parameter_mappable" : 0
					}
,
					"text" : "dict f6"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "dictionary", "", "", "", "" ],
					"patching_rect" : [ 37.0, 157.0, 61.0, 22.0 ],
					"saved_object_attributes" : 					{
						"embed" : 0,
						"legacy" : 0,
						"parameter_enable" : 0,
						"parameter_mappable" : 0
					}
,
					"text" : "dict f5"
				}

			}
, 			{
				"box" : 				{
					"id" : "9121967c",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 37.0, 18.0, 469.0, 20.0 ],
					"text" : "ThingSpeak → maxurl (only updated after the button on iv tester is pressed."
				}

			}
, 			{
				"box" : 				{
					"id" : "ea77447f",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 37.0, 49.0, 349.0, 22.0 ],
					"text" : "get https://api.thingspeak.com/channels/2860934/fields/5/last.txt"
				}

			}
, 			{
				"box" : 				{
					"id" : "8900b46d",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 135.0, 76.333340167999268, 349.0, 22.0 ],
					"text" : "get https://api.thingspeak.com/channels/2860934/fields/6/last.txt"
				}

			}
, 			{
				"box" : 				{
					"id" : "a5e77f64",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "dictionary", "" ],
					"patching_rect" : [ 37.0, 108.0, 80.0, 22.0 ],
					"text" : "maxurl"
				}

			}
, 			{
				"box" : 				{
					"id" : "0acb10ba",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "dictionary", "" ],
					"patching_rect" : [ 135.0, 108.333340167999268, 80.0, 22.0 ],
					"text" : "maxurl"
				}

			}
, 			{
				"box" : 				{
					"background" : 1,
					"bgcolor" : [ 1.0, 0.658824, 0.14902, 1.0 ],
					"fontname" : "Arial Bold",
					"hint" : "",
					"id" : "obj-39",
					"ignoreclick" : 1,
					"legacytextcolor" : 1,
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 395.0, 50.0, 20.0, 20.0 ],
					"rounded" : 60.0,
					"text" : "1",
					"textcolor" : [ 0.2, 0.2, 0.2, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"background" : 1,
					"bgcolor" : [ 1.0, 0.658824, 0.14902, 1.0 ],
					"fontname" : "Arial Bold",
					"hint" : "",
					"id" : "obj-38",
					"ignoreclick" : 1,
					"legacytextcolor" : 1,
					"maxclass" : "textbutton",
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "int" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 395.0, 109.0, 20.0, 20.0 ],
					"rounded" : 60.0,
					"text" : "2",
					"textcolor" : [ 0.2, 0.2, 0.2, 1.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-32", 0 ],
					"source" : [ "0acb10ba", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "0acb10ba", 0 ],
					"source" : [ "8900b46d", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 0 ],
					"source" : [ "a5e77f64", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "a5e77f64", 0 ],
					"source" : [ "ea77447f", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-34", 0 ],
					"source" : [ "getbody", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "url", 0 ],
					"source" : [ "msgurl", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-12", 0 ],
					"source" : [ "obj-15", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 1 ],
					"source" : [ "obj-15", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-20", 0 ],
					"source" : [ "obj-15", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 0 ],
					"source" : [ "obj-15", 3 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "url", 0 ],
					"source" : [ "obj-21", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-30", 0 ],
					"source" : [ "obj-25", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-26", 0 ],
					"source" : [ "obj-30", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "getbody", 0 ],
					"midpoints" : [ 519.5, 143.666642427444458, 589.5, 143.666642427444458 ],
					"source" : [ "obj-31", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-69", 0 ],
					"source" : [ "obj-32", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-30", 0 ],
					"source" : [ "obj-33", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-35", 0 ],
					"source" : [ "obj-34", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-33", 1 ],
					"midpoints" : [ 604.5, 276.499983668327332, 963.500011444091797, 276.499983668327332 ],
					"source" : [ "obj-35", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-15", 0 ],
					"source" : [ "obj-4", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-81", 0 ],
					"midpoints" : [ 100.166669368743896, 395.166678130626678, 57.500001430511475, 395.166678130626678 ],
					"source" : [ "obj-44", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-30", 0 ],
					"midpoints" : [ 638.5, 398.499987304210663, 598.5, 398.499987304210663 ],
					"source" : [ "obj-45", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-79", 0 ],
					"source" : [ "obj-6", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-32", 0 ],
					"midpoints" : [ 328.5, 143.0, 145.5, 143.0 ],
					"order" : 0,
					"source" : [ "obj-65", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 1 ],
					"midpoints" : [ 328.5, 143.0, 88.5, 143.0 ],
					"order" : 1,
					"source" : [ "obj-65", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-83", 1 ],
					"midpoints" : [ 156.5, 257.833340704441071, 81.0, 257.833340704441071 ],
					"source" : [ "obj-68", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-68", 0 ],
					"source" : [ "obj-69", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-80", 0 ],
					"source" : [ "obj-79", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-81", 0 ],
					"order" : 1,
					"source" : [ "obj-80", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-83", 0 ],
					"order" : 0,
					"source" : [ "obj-80", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-98", 0 ],
					"source" : [ "obj-81", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-81", 0 ],
					"order" : 1,
					"source" : [ "obj-83", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-86", 1 ],
					"midpoints" : [ 57.0, 293.833341777324677, 422.500001430511475, 293.833341777324677 ],
					"order" : 0,
					"source" : [ "obj-83", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-81", 0 ],
					"source" : [ "obj-86", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-81", 0 ],
					"source" : [ "obj-88", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "getbody", 0 ],
					"source" : [ "url", 0 ]
				}

			}
 ],
		"dependency_cache" : [ 			{
				"name" : "iv_finger_prints.js",
				"bootpath" : "~/Documents/Projects/iv_curve_thingspeak",
				"patcherrelativepath" : ".",
				"type" : "TEXT",
				"implicit" : 1
			}
 ],
		"autosave" : 0
	}

}
