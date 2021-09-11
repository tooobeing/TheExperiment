function Study()
%Demographics(2);
Parameter = Preparescreen();

%to save the data of the subject
%cd(['Sub' num2str(SubID)])
getResp = fopen('Test.dat' , 'a'); %creates a dat folder that contain the subject data
fprintf(getResp, '%s\t %s\t %s\t %s\t %s\t %s\t %s\n', 'testPosition', 'probe', 'CI', 'CIRT', 'response', 'listNo', 'wordNo'); %headers of the dat folder
fclose(getResp);

fid = fopen('data.txt', 'r');
numbers = textscan(fid, '%s');

%displays one to ten on an experiment screen
[rows cols] = size(numbers{1});
for i = 1:rows
    c = numbers{1}{i};
    %c = double(c);
    sub.words{i} = c;


Screen('TextSize', Parameter.window, 50);
Screen('TextFont', Parameter.window, 'Times');
[normBoundsRect, offsetBoundsRect] = Screen('TextBounds', Parameter.window, 'Hello world');
DrawFormattedText(Parameter.window, c, 'center', Parameter.centerX/2, [240,0,0]);

Screen('Flip', Parameter.window)
WaitSecs(.1)
end
Screen('CloseAll')
end