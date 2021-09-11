function Study()
%Demo = Demographics();
Parameter = Preparescreen();

%fid = fopen('data.txt', 'r');
%numbers = textscan(fid, '%s');

for i = 1:32
    listOpen = (['List' num2str(i) '.txt']);
    fid(i) = fopen(listOpen);
end

randList = randperm(32); %randomize the lists to show
for j = 1:7
    words(j) = textscan(fid(randList(j)), '%s');
    x = int2str(j);
    numofList = ['Liste', x];
    Screen('TextSize', Parameter.window, 50);  %parametreleri zaten ayarladim 
    Screen('TextFont', Parameter.window, 'Times'); %bunlari yazmaya gerek var mi bak
    DrawFormattedText(Parameter.window, numofList, 'center', [255 255 255]);
    
    %Screen('DrawText', Parameter.window, numofList, 'center', [255 255 255]);
    Screen('Flip', Parameter.window)
    WaitSecs(.1) %sureyi ayarla + ses kaydi koymak lazim
    
    for i = 1:10 %hardcodingi kaldir
        c = words{1, j}{i};
        c = double(c);
        Screen('DrawText', Parameter.window, c, 'center', [255 255 255]);
        Screen('Flip', Parameter.window);
        time = GetSecs;
    end
end




%displays one to ten on an experiment screen
%[rows cols] = size(numbers{1});
%for i = 1:rows
%    c = numbers{1}{i};
%    c = double(c);
%    sub.words{i} = c;


%Screen('TextSize', Parameter.window, 50);
%Screen('TextFont', Parameter.window, 'Times');
%[normBoundsRect, offsetBoundsRect] = Screen('TextBounds', Parameter.window, 'Hello world');
%DrawFormattedText(Parameter.window, c, 'center', Parameter.centerX/2, [240,0,0]);

%Screen('Flip', Parameter.window)
%WaitSecs(.1)
%end
Screen('CloseAll')
end