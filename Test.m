function Test(sub_id)
    Parameter = Preparescreen();
    probelist(sub_id);
   % study function is added here   
    Study(Parameter, sub_id);           
   
    %text = 'Test aşamasına geçmek için boşluk tuşuna basın';
    %text = double(text);
    %DrawFormattedText(Parameter.window, text, 'center', 'center');
    %Screen('Flip', Parameter.window);
    
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
    
    for i = 1:6
        pairs = scanprobelist{1,1}{i};
        %DrawFormattedText(Parameter.window, double('Bu çifti daha önce gördünüz mü?'), 'center', Parameter.centerY/3);
        Screen('DrawText', Parameter.window, 'Bu çifti daha önce gördünüz mü?', Parameter.centerX, Parameter.centerY/3);
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
        %text = 'Bu kelime çiftini gördüğünüz listeden başka bir kelime yazın.';
        %DrawFormattedText(Parameter.window, double(text), 'center', 'center');
        %Screen('Flip', Parameter.window);


        %% recall 
        % when this works, MATLAB crashes
        
        


   
    
     Screen('Closeall');
end
