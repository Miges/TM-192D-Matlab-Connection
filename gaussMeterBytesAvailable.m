function gaussMeterBytesAvailable(obj,event)
initByte = fread(obj, 1);
commandHex = dec2hex(fread(obj, 1));

x = fread(obj, 1, 'int16');
y = fread(obj, 1, 'int16');
z = fread(obj, 1, 'int16');

date = fread(obj, 1, 'int16');


year = 2000 + binaryVectorToDecimal(bitget(date, 10:16));
month = binaryVectorToDecimal(bitget(date, 6:9));
day = binaryVectorToDecimal(bitget(date, 1:5));

time = fread(obj, 1, 'int16');
status = fread(obj, 1);

hour = binaryVectorToDecimal([bitget(time, 13:16), bitget(status, 1)]);
minute =  binaryVectorToDecimal(bitget(time, 7:12));
second = binaryVectorToDecimal(bitget(time, 1:6));

unit = bitget(status, 2);
if (unit == 1)
    strUnit = 'micro Tesla';
else
    strUnit = 'mG'
end

xRank = 20 * 10^binaryVectorToDecimal(bitget(status, 3:4));
yRank = 20 * 10^binaryVectorToDecimal(bitget(status, 5:6));
zRank = 20 * 10^binaryVectorToDecimal(bitget(status, 7:8));

CRC = fread(obj, 1);

m = sqrt(x^2 + y^2 + z^2);

%for display
disp([num2str(m),' ', strUnit,' --- ', num2str(hour), ':', num2str(minute), ':',num2str(second), ' - ', num2str(day), '/', num2str(month), '/', num2str(year)]);

% data(dataII).X = x;
% data(dataII).Y = y;
% data(dataII).Z = z;
% data(dataII).Year = year;
% data(dataII).Month = month;
% data(dataII).Day = day;
% data(dataII).Hour = hour;
% data(dataII).Minute = minute;
% data(dataII).Second = second;
% data(dataII).Unit = unit;
% data(dataII).XRank = xRank;
% data(dataII).YRank = yRank;
% data(dataII).ZRank = zRank;

%dataII = dataII + 1;
%M = [x,y,z,year,month,day,hour,minute,second,unit,xRank,yRank,zRank];
%dlmwrite('data.csv',M,'-append')
global hLine;
global iii;


X = get(hLine, 'XData');
Y = get(hLine, 'YData');

X = [X now];
Y = [Y m];

set(hLine, 'XData', X, 'YData', Y);

drawnow

end


