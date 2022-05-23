% This is test for practice part of the experiment
% saving the subject's answers is not necessary 
% probe list is predetermined for every participant
function [sub] = Testpractice(Parameter)
    
    randProbeList = {'titreme', 'suistimal'; 'radyo', 'bitki'; 'eksiklik', 'vals'};
    text1 = 'Test aşamasına geçmek için boşluk tuşuna basın';
    DrawFormattedText(Parameter.window, double(text1), 'center', 'center');
    Screen('Flip', Parameter.window);    
    
    RestrictKeysForKbCheck([Parameter.space]);
    keyIsDown = 0;
    while keyIsDown == 0
          [keyIsDown, secs, keyCode] = KbCheck;
    end

    while keyIsDown
          [keyIsDown, ~, ~] = KbCheck;
    end

    [rows ~] = size(randProbeList); 
    %% recognition
    for i = 1:rows
        DrawFormattedText(Parameter.window, double('Bu çifti daha önce gördünüz mü?'), 'center', Parameter.centerY/3);        
        Screen('DrawText', Parameter.window, double(randProbeList{i,1}), Parameter.centerX1-100, Parameter.centerY, [255 255 255]);
        Screen('DrawText', Parameter.window, double(randProbeList{i,2}), Parameter.centerX2-100, Parameter.centerY, [255 255 255]);
        Screen('DrawText', Parameter.window, 'c:evet', Parameter.width/3, Parameter.height*2/3);
        Screen('DrawText', Parameter.window, double('m:hayır'), Parameter.width*2/3, Parameter.height*2/3);
        probeTime = Screen('Flip', Parameter.window);


        % collect recognition judgments yes = c no = m
        FlushEvents;
        RestrictKeysForKbCheck([Parameter.yes, Parameter.no]);
        keyIsDown = 0;
        while keyIsDown == 0
            ch = GetChar; % to keep track of the pressed key 
            [keyIsDown, seconds, keyCode] = KbCheck;
            sub.responseRec{i,1} = ch;
            sub.recogRT(i,1) = seconds - probeTime;
        end 
        
        FlushEvents;
        Parameter.ISI;

        % if participant recognize the word, recall phase starts
        % emtpy response is put here to save nothing when recognition is no
        if sub.responseRec{i,1} == KbName(Parameter.yes)      
            %% recall  
            % collect recall responses
            text2 = 'Bu kelime çiftini gördüğünüz listeden başka bir kelime yazın.';
            DrawFormattedText(Parameter.window, double(text2), 'center', Parameter.centerY/3);
            Screen('Flip', Parameter.window);
            response = '';
            while 1
                ch = GetChar;
                if ch == 13 % enter
                    if length(response) == 0
                        sub.response{i,1} = sprintf('%s\n', 'pass');
                    end
                    break
                elseif ch == 8 % backspace
                    if length(response) > 0
                        response = response(1:length(response)-1);
                    else 
                        response = '';
                    end
                else
                    response = [response ch];
                end                
                if length(response) > 0
                    response = double(response);
                    [normBoundsRect, ~] = Screen('TextBounds', Parameter.window, response);
                    Screen('DrawText', Parameter.window, response, Parameter.centerX - normBoundsRect(3)/2, Parameter.centerY - normBoundsRect (4)/1.5, [255, 255, 255]);
                end
                Screen('Flip', Parameter.window);
                sub.response{i,1} = sprintf('%s\n', response); % recall responses are saved
            end     
            else 
                sub.response{i,1} = sprintf('%s\n', '');
            end      
  
end
