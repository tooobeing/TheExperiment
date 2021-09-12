%This function prepares the parameter of the experiment
function Parameter = Preparescreen()

    HideCursor;
    % for Turkish characters
    slCharacterEncoding('UTF-8')
    Screen('Preference', 'TextEncodingLocale', 'UTF-8'); 
    Screen('Preference', 'SkipSyncTests', 1); %optional-should be removed in actual the experiment
    [Parameter.window, Parameter.rect] = Screen('OpenWindow', 0,[0,0,0]);
    Parameter.width = Parameter.rect(3);
    Parameter.heigth = Parameter.rect(4);
    Parameter.centerX = Parameter.rect(3)/2;
    Parameter.centerY = Parameter.rect(4)/2;

    Screen('TextFont', Parameter.window, 'Times');
    Screen('TextSize', Parameter.window, 60);

    %Keys which will be used throughout the experiment
    Parameters.yes = KbName('c');
    Parameters.no = KbName('m');
    Parameters.return = KbName('return');
    Parameters.backspace = KbName('backspace');
    Parameters.space = KbName('space');
    Parameters.up = KbName('up');
    Parameters.down = KbName('down');

    Parameter.color = [255,255,255];



end