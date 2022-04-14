%This function prepares the parameters of the experiment
function Parameter = Preparescreen(Parameter)

    %HideCursor;
    %ListenChar(2);
    % for Turkish characters
    slCharacterEncoding('UTF-8')
    Screen('Preference', 'TextEncodingLocale', 'UTF-8'); 
    Screen('Preference', 'SkipSyncTests', 1); %optional-should be removed in actual the experiment
    [Parameter.window, Parameter.rect] = Screen('OpenWindow', 0,[0,0,0]); 
    Parameter.width = Parameter.rect(3);
    Parameter.height = Parameter.rect(4);
    Parameter.centerX = Parameter.rect(3)/2;
    Parameter.centerX1 = Parameter.rect(3)/4;
    Parameter.centerX2 = 3*Parameter.rect(3)/4;
    Parameter.centerY = Parameter.rect(4)/2;

    Screen('TextFont', Parameter.window, 'Times');
    Screen('TextSize', Parameter.window, 60);
    Parameter.color = [255,255,255];

    %Keys which will be used throughout the experiment
    Parameter.yes = KbName('c');
    Parameter.no = KbName('m');
    Parameter.return = KbName('return');
    Parameter.backspace = KbName('backspace');
    Parameter.space = KbName('space');
    Parameter.up = KbName('up');
    Parameter.down = KbName('down');

    % list numbers etc
    Parameter.numoflist = 10; 
    Parameter.distractt = 45;
    Parameter.distracttList = 10;
    
    % Inter-stimulus Interval
    Parameter.ISI = WaitSecs(0.5);
    %Parameter.sub_id = sub_id;
    %Parameter.datadir = ['../Data/Sub' num2str(Parameter.sub_id) '/'];
    
    %ShowCursor;



end