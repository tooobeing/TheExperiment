%This function prepares the parameter of the experiment
function Parameter = Preparescreen()

HideCursor;

Screen('Preference', 'SkipSyncTests', 1); %optional-should be removed in actual the experiment
[Parameter.window, Parameter.rect] = Screen('OpenWindow', 0,[0,0,0]);
Parameter.width = Parameter.rect(3);
Parameter.heigth = Parameter.rect(4);
Parameter.centerX = Parameter.rect(3)/2;
Parameter.centerY = Parameter.rect(4)/2;

Screen('TextFont', Parameter.window, 'Times');
Screen('TextSize', Parameter.window, 60);

%Keys that will be using during the experiment
Parameter.yes = KbName('z');
Parameter.no = KbName('m');
Parameter.space = KbName('space');

Parameter.color = [255,255,255];



end