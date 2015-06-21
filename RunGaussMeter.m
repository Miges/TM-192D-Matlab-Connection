
%**************************************************************************
% Select the COM port
% 
% allComPorts = findcomports();
% [Selection,ok] = listdlg('ListString',allComPorts);
% selcom = allComPorts{Selection};
% selectedComPortNum = str2num(selcom(length('COM')+1:end));
selectedComPortNum = 3;
        
%**************************************************************************
% INITIALISE SERIAL CONNECTION

serialConnection = serial(strcat('COM',num2str(selectedComPortNum)));

% ...
%                 strcat('COM',num2str(selectedComPortNum)),...
%                 '',38400,'DataBits',8,'Parity','none',...
%                 'StopBits',1,'Terminator','LF','InputBufferSize',11);
            


serialConnection.ByteOrder = 'littleEndian';
serialConnection.BaudRate = 38400;
serialConnection.DataBits = 8;
serialConnection.StopBits = 1;
serialConnection.Parity = 'none';
serialConnection.BytesAvailableFcnCount = 14;
serialConnection.BytesAvailableFcn = @gaussMeterBytesAvailable;
serialConnection.BytesAvailableFcnMode = 'byte';
serialConnection.InputBufferSize = 512;

dataII = 0;
data = struct('X',{},'Y',{},'Z',{},'Year',{},'Month',{},'Day',{},'Hour',{},'Minute',{},'Second',{},'Unit',{},'XRank',{},'YRank',{},'ZRank',{});
    
global hLine;
figure(1); %# Generate a blank line and return the line handle
hLine = line(nan, nan);

global iii;
iii = 1;

try
    %Open the com port created.
    fopen(serialConnection);
catch MyErr
    fclose(instrfind);
    fopen(serialConnection);
end

    