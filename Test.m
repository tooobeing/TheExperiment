function Test(sub_id)   
    probelist(sub_id);

    Parameter = Preparescreen(sub_id);
    Study(Parameter, sub_id);
           
   
    
    DrawFormattedText(Parameter.window, double(sprintf('Test aşamasına geçmek için boşluk tuşuna basın')), 'center', 'center');
    Screen('Flip', Parameter.window);
    
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
    
    for i = 1:3
        pairs = scanprobelist{1,1}{i};
        DrawFormattedText(Parameter.window, double(sprintf('Bu çifti daha önce gördünüz mü?')), 'center', Parameter.centerY/3);
        Screen('DrawText', Parameter.window, pairs, Parameter.centerX, Parameter.centerY, [255 255 255] );
        Screen('DrawText', Parameter.window, 'evet', Parameter.width/3, Parameter.height*2/3);
        Screen('DrawText', Parameter.window, 'hayır', Parameter.width*2/3, Parameter.height*2/3);
        probeTime = Screen('Flip', Parameter.window);
        
        % collect recognition judgments yes = c no = m
        RestrictKeysForKbCheck([Parameter.yes, Parameter.no]);
        while 1
            ch = GetChar;
            [keyIsDown, seconds, keyCode] = KbCheck;
            response{i} = ch;
            recogRT(i) = seconds - probeTime;
            break
        end 
        FlushEvents;

        % collect recall responses
        text = 'Bu kelime çiftini gördüğünüz listeden başka bir kelime yazın.';
        DrawFormattedText(Parameter.window, double(text), 'center', 'center');
        Screen('Flip', Parameter.window);

        % recall 
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

                if length(response) > 0
                    response = double(response);
                    Screen('TextSize', Parameter.window, 40);
                    [normBoundsRect, ~] = Screen('TextBounds', Parameter.window, response);
                    Screen('DrawText', Parameter.window, response, Parameter.centerX - normBoundsRect(3)/2, centerY - normBoundsRect (4)/1.5);
                end
                Screen('Flip', Parameter.window);
            end
    end



   
    
     Screen('Closeall');
end
