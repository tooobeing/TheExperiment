function Test(Parameter, sub_id)
    [randProbeList testPair] = probelist(); % brings probeList for test        
    sub.testPair = testPair;
    
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

    [rows cols] = size(randProbeList); 
    %% recognition
    for i = 1:rows
        DrawFormattedText(Parameter.window, double('Bu çifti daha önce gördünüz mü?'), 'center', Parameter.centerY/3);        
        Screen('DrawText', Parameter.window, double(randProbeList{i,1}), Parameter.centerX1-100, Parameter.centerY, [255 255 255]);
        Screen('DrawText', Parameter.window, double(randProbeList{i,2}), Parameter.centerX2-100, Parameter.centerY, [255 255 255]);
        Screen('DrawText', Parameter.window, 'evet', Parameter.width/3, Parameter.height*2/3);
        Screen('DrawText', Parameter.window, double('hayır'), Parameter.width*2/3, Parameter.height*2/3);
        probeTime = Screen('Flip', Parameter.window);

        % save the presented words 
        sub.presented{i,1} = randProbeList{i,1};
        sub.presented{i,2} = randProbeList{i,2};

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
   
        %% saving the probe list position
            testfile = fopen(sprintf('Study_Sub%d.dat', sub_id), 'r');
            study = textscan(testfile, '%s \t %s \t %d \t %d \t %d \n');
            probe = randProbeList{i,1};
            probe = convertCharsToStrings(probe);
            [rows ~] = size(study{1,1});
            for t = 1:rows
                word = study{1,1}{t,1};
                word = convertCharsToStrings(word);
                word= word+" ";
                if probe == word
                 listno = study{1,3}(t);
                 wordno = study{1,4}(t);
                    break
                else 
                    listno=0;
                    wordno=0;
                end
            end     
        fprintf(Parameter.test_file, '%s \t %s \t %d \t %d \t %s \t %s\n', sub.presented{i,1}, sub.presented{i,2}, listno, wordno, sub.responseRec{i,1}, sub.response{i,1});
    end
    fclose(testfile);    
    save test.mat
end
