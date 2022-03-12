function Test(sub_id)   
    probelist(sub_id);

    Parameter = Preparescreen(sub_id);
    %Study(Parameter, sub_id);
           
   
    
    DrawFormattedText(Parameter.window, double(sprintf('Test aşamasına geçmek için boşluk tuşuna basın')), 'center', 'center');
    Screen('Flip', Parameter.window);
    %WaitSecs(2);
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
        DrawFormattedText(Parameter.window, double(sprintf('Bu çifti daha önce gördünüz mü?')), 'center', 'center')
        %Screen('DrawText', Parameter.window, 'Bu çifti daha önce gördünüz mü?', Parameter.centerX, Parameter.rect(4)/3, [255 255 255] );
        Screen('DrawText', Parameter.window, pairs, Parameter.centerX, Parameter.centerY, [255 255 255] );
        Screen('Flip', Parameter.window);
        WaitSecs(0.5);
        sprintf('%s', scanprobelist{1,1}{i});
    end



   
    
     Screen('Closeall');
end
