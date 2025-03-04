% Channel settings
channelID = 2860934;
readAPIKey = 'MA2OFWB36S4YOVUP';

% Read latest data
data = thingSpeakRead(channelID, 'Fields', [5,6], 'NumPoints', 1, 'OutputFormat', 'table', 'ReadKey', readAPIKey);

% Get the strings from the table
voltageStr = data.VCurveJson{1};
currentStr = data.ICurveJson{1};

% Convert to arrays
voltages = str2double(strsplit(voltageStr, ','));
currents = str2double(strsplit(currentStr, ','));

% Calculate power
power = voltages .* currents / 1000;

% Create figure
figure

% Plot I-V curve
plot(voltages / 1000, currents, 'b-o', 'LineWidth', 2);
grid on;
xlabel('Voltage (V)');
ylabel('Current (mA)');
title('Solar Cell I-V Curve');
xlim([0 max(voltages / 1000)]);  % This will make the x-axis start at 0 and end at max voltage
ylim([0 max(currents * 1.2)]); 

% Add power curve
yyaxis right;
plot(voltages / 1000, power, 'r-o', 'LineWidth', 2);
ylabel('Power (mW)');
ylim([0 max(power * 1.8)]); 

% Mark MPP
[maxPower, idx] = max(power);
hold on;
plot(voltages(idx) / 1000, power(idx), 'r*', 'MarkerSize', 15);
text(voltages(idx) / 1000, power(idx), sprintf('\n MPP: %.1f mW', maxPower), 'VerticalAlignment', 'top');

% Styling
grid on;
set(gca, 'FontSize', 10);

% Legend below
legend('I-V Curve', 'Power Curve', 'Location', 'southoutside', 'Orientation', 'horizontal');