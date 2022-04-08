%function Test(sub_id)
    Parameter = Preparescreen();
    %probeList = probelist(); % brings probeList for test
   
   % study function is added here   
    %Study(Parameter, sub_id);           
   
    text1 = 'Test aşamasına geçmek için boşluk tuşuna basın';
    %[normBoundsRect, ~] = Screen('TextBounds', Parameter.window, text1);
    %text = double(text);
    %DrawFormattedText(Parameter.window, double(text1), 'center', Parameter.centerY);
    Screen('DrawText', Parameter.window, text1, Parameter.centerX1 , Parameter.centerY, [255 255 255]);
    Screen('Flip', Parameter.window);    
    
    RestrictKeysForKbCheck([Parameter.space]);
    keyIsDown = 0;
    while keyIsDown == 0
          [keyIsDown, secs, keyCode] = KbCheck;
    end

    while keyIsDown
          [keyIsDown, ~, ~] = KbCheck;
    end



    [rows cols] = size(probeList); 
    

    %% recognition
    for i = 1:3 % rows
        %[normBoundsRect1, ~] = Screen('TextBounds', Parameter.window, probeList{i,1}); %kullanınca screen hatası veriyor
        %[normBoundsRect2, ~] = Screen('TextBounds', Parameter.window, probeList{i,2});

        DrawFormattedText(Parameter.window, double('Bu çifti daha önce gördünüz mü?'), 'center', Parameter.centerY/3);        
        Screen('DrawText', Parameter.window, probeList{i,1}, Parameter.centerX1, Parameter.centerY, [255 255 255]);
        Screen('DrawText', Parameter.window, probeList{i,2}, Parameter.centerX2, Parameter.centerY, [255 255 255]);
        Screen('DrawText', Parameter.window, 'evet', Parameter.width/3, Parameter.height*2/3);
        Screen('DrawText', Parameter.window, 'hayır', Parameter.width*2/3, Parameter.height*2/3);
        probeTime = Screen('Flip', Parameter.window);

        % save the presented words 
        sub.presented{i,1} = probeList{i,1};
        sub.presented{i,2} = probeList{i,2};

        

        % collect recognition judgments yes = c no = m
        FlushEvents;
        RestrictKeysForKbCheck([Parameter.yes, Parameter.no]);
        keyIsDown = 0;
        while keyIsDown == 0
            ch = GetChar; % to keep track of the pressed key 
            [keyIsDown, seconds, keyCode] = KbCheck;
            sub.responseRec{i,1} = ch;
            sub.recogRT(i,1) = seconds - probeTime;
            %break % for restrict keys to recognition
        end 
        
        FlushEvents;
        Parameter.ISI;

        % if participant recognize the word, recall phase starts
        response = ''; % emtpy response is put here to save nothing when recognition is no
        if sub.responseRec{i,1} == KbName(Parameter.yes)      
            %% recall  
            % collect recall responses
            text2 = 'Bu kelime çiftini gördüğünüz listeden başka bir kelime yazın.';
            DrawFormattedText(Parameter.window, double(text2), 'center', Parameter.centerY/3);
            Screen('Flip', Parameter.window);
            % recall yaparken bu yazı ekranda kalsın istiyorum sonra bakabilirsin
                  
            
            while 1
                ch = GetChar;
                if ch == 13 % enter
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
        elseif sub.responseRec{i,1} == KbName(Parameter.no) 
            sub.response{i,1} = sprintf('%s\n', response);
        end      
   fprintf(Parameter.test_file, '\n %s \t %s', sub.presented{i,1}, sub.presented{i,2}); % bunu tanımla
    end

     Screen('CloseAll');
    
%end
