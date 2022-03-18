%function Test(sub_id)
    Parameter = Preparescreen();
    %probelist(sub_id);
    %[normBoundsRect, ~] = Screen('TextBounds', Parameter.window);
   % study function is added here   
   % Study(Parameter, sub_id);           
   
    %text = 'Test aşamasına geçmek için boşluk tuşuna basın';
    %text = double(text);
    %DrawFormattedText(Parameter.window, double(sprintf('Test aşamasına geçmek için boşluk tuşuna basın')), 'center', 'center');
    Screen('DrawText', Parameter.window, 'Test aşamasına geçmek için boşluk tuşuna basın', Parameter.centerX, Parameter.centerY, [255 255 255])
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
    
    %for i = 1:6
        pairs = scanprobelist{1,1}{1};
        %pairs = double(pairs);
        %DrawFormattedText(Parameter.window, double('Bu çifti daha önce gördünüz mü?'), 'center', Parameter.centerY/3);
        Screen('DrawText', Parameter.window, 'Bu çifti daha önce gördünüz mü?', Parameter.centerX, Parameter.centerY/3);
        Screen('DrawText', Parameter.window, pairs, Parameter.centerX, Parameter.centerY, [255 255 255]);
        Screen('DrawText', Parameter.window, 'evet', Parameter.width/3, Parameter.height*2/3);
        Screen('DrawText', Parameter.window, 'hayır', Parameter.width*2/3, Parameter.height*2/3);
        Screen('Flip', Parameter.window);
        
        % collect recognition judgments yes = c no = m
        keyIsDown = 0;
        RestrictKeysForKbCheck([Parameter.yes, Parameter.no]);
        while keyIsDown == 0
            %ch = GetChar;
            [keyIsDown, seconds, keyCode] = KbCheck;
            %response{i} = ch;
            %recogRT(i) = seconds - probeTime;
            break
        end 
        while keyIsDown % burada, sadece tuş basılı iken KbCheck yap diyoruz.
        [keyIsDown, ~, ~] = KbCheck;
        end

        FlushEvents;

        % collect recall responses
        %text = 'Bu kelime çiftini gördüğünüz listeden başka bir kelime yazın.';
        %DrawFormattedText(Parameter.window, double(text), 'center', 'center');
        %Screen('Flip', Parameter.window);


        %% recall 
        % when this works, MATLAB crashes
        
        


   
    
     Screen('Closeall');
    %end
%end
