%function Test(sub_id)
    Parameter = Preparescreen();
    %probelist(sub_id);
   
   % study function is added here   
   % Study(Parameter, sub_id);           
   
    text = 'Test aşamasına geçmek için boşluk tuşuna basın';
     %[normBoundsRect, ~] = Screen('TextBounds', Parameter.window, text);
    %text = double(text);
    %DrawFormattedText(Parameter.window, double(sprintf('Test aşamasına geçmek için boşluk tuşuna basın')), 'center', 'center');
    Screen('DrawText', Parameter.window, text, Parameter.centerX, Parameter.centerY, [255 255 255])
    Screen('Flip', Parameter.window);
    %WaitSecs(1);      
    
    RestrictKeysForKbCheck([Parameter.space]);
    keyIsDown = 0;
    while keyIsDown == 0
          [keyIsDown, secs, keyCode] = KbCheck;
    end

    while keyIsDown
          [keyIsDown, ~, ~] = KbCheck;
    end

    f = fopen('probelisst.txt', 'r');
    scanprobelist = textscan(f, '%s');
    fclose(f); % cannot close the probelist
    [rows cols] = size(scanprobelist{1,1});
    


    for i = 1:4
        pairs = scanprobelist{1,1}{i};
        %pairs = double(pairs);
        DrawFormattedText(Parameter.window, double('Bu çifti daha önce gördünüz mü?'), 'center', Parameter.centerY/3);
        %Screen('DrawText', Parameter.window, 'Bu çifti daha önce gördünüz mü?', Parameter.centerX, Parameter.centerY/3);
        Screen('DrawText', Parameter.window, pairs, Parameter.centerX, Parameter.centerY, [255 255 255]);
        Screen('DrawText', Parameter.window, 'evet', Parameter.width/3, Parameter.height*2/3);
        Screen('DrawText', Parameter.window, 'hayır', Parameter.width*2/3, Parameter.height*2/3);
        Screen('Flip', Parameter.window);
        

        % collect recognition judgments yes = c no = m
        keyIsDown = 0;
        RestrictKeysForKbCheck([Parameter.yes, Parameter.no]);
        while keyIsDown == 0
            ch = GetChar;
            [keyIsDown, seconds, keyCode] = KbCheck;
            responseRec{i} = ch;
            %recogRT(i) = seconds - probeTime;
            break
        end 
        while keyIsDown % burada, sadece tuş basılı iken KbCheck yap diyoruz.
        [keyIsDown, ~, ~] = KbCheck;
        end

        FlushEvents;

        % collect recall responses
        text = 'Bu kelime çiftini gördüğünüz listeden başka bir kelime yazın.';
        DrawFormattedText(Parameter.window, double(text), 'center', Parameter.centerY/3);
        Screen('Flip', Parameter.window);
        % recall yaparken bu yazı ekranda kalsın istiyorum sonra
        % bakabilirsin


        %% recall        
        response = '';
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
                    Screen('TextSize', Parameter.window, 40);
                    [normBoundsRect, ~] = Screen('TextBounds', Parameter.window, response);
                    Screen('DrawText', Parameter.window, response, Parameter.centerX - normBoundsRect(3)/2, Parameter.centerY - normBoundsRect (4)/1.5, [255, 255, 255]);
                end
                Screen('Flip', Parameter.window);
        end            
            sub.response = response;
        
        


   
    end
     Screen('CloseAll');
    
%end
