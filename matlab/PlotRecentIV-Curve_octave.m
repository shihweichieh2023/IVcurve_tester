% ThingSpeak Channel Configuration
channelID = 2860934;
readAPIKey = 'MA2OFWB36S4YOVUP';
numCurves = 5;  % Number of recent curves to fetch

% Create the URL for the CSV data request
baseURL = sprintf('https://api.thingspeak.com/channels/%d/feeds.csv', channelID);
dataURL = sprintf('%s?api_key=%s&results=%d&fields=5,6', baseURL, readAPIKey, numCurves);

% Debug: Print URL
disp(['Requesting URL: ' dataURL]);

% Fetch data from ThingSpeak
disp('Fetching data from ThingSpeak...');
response = urlread(dataURL);
disp('Raw response from ThingSpeak:');
disp(response);

% Split response into lines
lines = strsplit(response, '\n');

% Define colors for different curves
colors = {'b', 'r', 'g', 'm', 'c'};
legendEntries = {};

% Create figure
figure

% Initialize maximum values
maxVoltage = 0;
maxCurrent = 0;
maxPwr = 0;

% Process each line (skipping header)
for i = 2:min(length(lines), numCurves+1)
    if isempty(lines{i})
        continue;
    end
    
    % Split the line into fields, preserving quoted strings
    line = lines{i};
    fields = {};
    inQuotes = false;
    currentField = '';
    
    for j = 1:length(line)
        char = line(j);
        if char == '"'
            inQuotes = !inQuotes;
        elseif char == ',' && !inQuotes
            fields{end+1} = currentField;
            currentField = '';
        else
            currentField = [currentField char];
        end
    end
    fields{end+1} = currentField;
    
    % Extract timestamp
    timestamp = fields{1};
    timeStr = strsplit(timestamp, ' '){2};  % Get just the time part
    
    % Get voltage and current arrays (fields 5 and 6)
    voltageStr = fields{7};  % Field 5 is in column 7 (after created_at,entry_id,field1,field2,field3,field4)
    currentStr = fields{8};  % Field 6 is in column 8
    
    % Remove quotes and make into valid array strings
    voltageStr = ['[' strrep(voltageStr, '"', '') ']'];
    currentStr = ['[' strrep(currentStr, '"', '') ']'];
    
    % Convert to arrays using eval (safe here since we control the input)
    voltages = eval(voltageStr);
    currents = eval(currentStr);
    
    % Calculate power
    power = (voltages .* currents) / 1000;  % Convert to mW
    
    % Update maximum values
    maxVoltage = max(maxVoltage, max(voltages));
    maxCurrent = max(maxCurrent, max(currents));
    maxPwr = max(maxPwr, max(power));
    
    % Plot with current color
    curveColor = colors{mod(i-2, length(colors)) + 1};
    
    % Plot I-V curve
    hold on;
    h = plot(voltages / 1000, currents, [curveColor '-o'], 'LineWidth', 2);
    
    % Add power curve
    plot(voltages / 1000, power, [curveColor '--o'], 'LineWidth', 2);
    
    % Mark MPP
    [maxPower, idx] = max(power);
    plot(voltages(idx) / 1000, power(idx), [curveColor '*'], 'MarkerSize', 15);
    text(voltages(idx) / 1000, power(idx), sprintf('\n %.1f mW', maxPower), ...
         'VerticalAlignment', 'top', 'Color', curveColor);
         
    % Add to legend entries
    legendEntries{end+1} = sprintf('%s - IV', timeStr);
    legendEntries{end+1} = sprintf('%s - Power', timeStr);
end

% Set labels and title
xlabel('Voltage (V)');
ylabel('Current (mA) / Power (mW)');
title('Solar Cell I-V and Power Curves');
grid on;

% Add legend
legend(legendEntries, 'Location', 'southoutside', 'Orientation', 'horizontal');

% Set axis limits with some margin
xlim([0 maxVoltage/1000 * 1.1]);  % Convert to V
ylim([0 max(maxCurrent, maxPwr) * 1.2]);  % Keep in mA and mW

% Wait for keypress then close
pause;
close all;