function Study(Parameter, sub_id, cycle)
    % The Study function only displays the lists in the randomized fashion
    [studyList, newpairList] = listconstruction(sub_id);
    Screen('TextSize', Parameter.window, 60);
    
    %% List presentation 
    % Ten or five seperate lists will be displayed during the experiment
    rand = randperm(10); % randomization of lists
    randword = randperm(10); % randomization of words within lists
    if cycle == 1 % in the first cycle

       for j = 1:5 % 10|5 olacak        
            whichList = int2str(j);
            numofList = ['Liste ', whichList];
            DrawFormattedText(Parameter.window, numofList, 'center', 'center');
            Screen('Flip', Parameter.window);                            
            WaitSecs(1); %sureyi ayarla + ses kaydi koymak lazim

        % displays the words of the selected lists
        % word-pairs randomized within lists
        [rows cols] = size(studyList{1,1});        
        for i = 1:rows
            Screen('DrawText', Parameter.window, double(studyList{1, rand(j)}{randword(i),1}), Parameter.centerX1-100, Parameter.centerY, [255 255 255]);
            Screen('DrawText', Parameter.window, double(studyList{1, rand(j)}{randword(i),2}), Parameter.centerX2-100, Parameter.centerY, [255 255 255]);
            % presented word-pair is recorded, j represents the list, i is the word
            sub.word{j}{i,1} = studyList{1, rand(j)}{randword(i),1}; 
            sub.word{j}{i,2} = studyList{1, rand(j)}{randword(i),2};            
            preFlip = Screen('Flip', Parameter.window);

            % waits for subject to press the 'b' key to see the next word-pair
            RestrictKeysForKbCheck([Parameter.keystudy]);          
            keyIsDown = 0;
            while keyIsDown == 0
                [keyIsDown, secs, keyCode] = KbCheck;
            end

            while keyIsDown
                [keyIsDown, ~, ~] = KbCheck;
            end
            sub.RT{j}{i,1} = secs-preFlip; % the duration of a pair to study
            % save the studied pair, list no and test position of the pair to study list
            fprintf(Parameter.study_file, '\n %s \t %s \t %d \t %d \t %d',studyList{1, rand(j)}{i,1}, studyList{1, rand(j)}{i,2}, j, i, sub.RT{j}{i,1});
        end
        textaritmetik = 'Şimdi aritmetik aşamasına geçeceksiniz. \nDevam etmek için boşluk tuşuna basın';
        DrawFormattedText(Parameter.window, double(textaritmetik), 'center', 'center');
        Screen('Flip', Parameter.window);
            RestrictKeysForKbCheck([Parameter.space]);          
            keyIsDown = 0;
            while keyIsDown == 0
                [keyIsDown, secs, keyCode] = KbCheck;
            end

            while keyIsDown
                [keyIsDown, ~, ~] = KbCheck;
            end

        Distraction(Parameter); % süresini ayarlamak lazım %1dk olacak
        DrawFormattedText(Parameter.window, double('Bekleyiniz.'), 'center', 'center');
        Screen('Flip', Parameter.window);
        WaitSecs(3);
       end

    elseif cycle == 2
       for j = 6:10 % 10|5 olacak        
        whichList = int2str(j);
        numofList = ['Liste ', whichList];
        DrawFormattedText(Parameter.window, numofList, 'center', 'center');
        Screen('Flip', Parameter.window);                            
        WaitSecs(1); %sureyi ayarla + ses kaydi koymak lazim
       
        %displays the words of the selected lists
        % word-pairs randomized within lists
        [rows cols] = size(studyList{1,1});        
        for i = 1:rows
            Screen('DrawText', Parameter.window, double(studyList{1, rand(j)}{randword(i),1}), Parameter.centerX1-100, Parameter.centerY, [255 255 255]);
            Screen('DrawText', Parameter.window, double(studyList{1, rand(j)}{randword(i),2}), Parameter.centerX2-100, Parameter.centerY, [255 255 255]);
            % presented word-pair is recorded, j represents the list, i is the word
            sub.word{j}{i,1} = studyList{1, rand(j)}{randword(i),1}; 
            sub.word{j}{i,2} = studyList{1, rand(j)}{randword(i),2};            
            preFlip = Screen('Flip', Parameter.window);

            % waits for subject to press the 'b' key to see the next word-pair
            RestrictKeysForKbCheck([Parameter.keystudy]);          
            keyIsDown = 0;
            while keyIsDown == 0
                [keyIsDown, secs, keyCode] = KbCheck;
            end

            while keyIsDown
                [keyIsDown, ~, ~] = KbCheck;
            end
            sub.RT{j}{i,1} = secs-preFlip; % the duration of a pair to study
            % save the studied pair, list no and test position of the pair to study list
            fprintf(Parameter.study_file, '\n %s \t %s \t %d \t %d \t %d',studyList{1, rand(j)}{i,1}, studyList{1, rand(j)}{i,2}, j, i, sub.RT{j}{i,1});
        end
        textaritmetik = 'Şimdi aritmetik aşamasına geçeceksiniz. \nDevam etmek için boşluk tuşuna basın';
        DrawFormattedText(Parameter.window, double(textaritmetik), 'center', 'center');
        Screen('Flip', Parameter.window);
            RestrictKeysForKbCheck([Parameter.space]);          
            keyIsDown = 0;
            while keyIsDown == 0
                [keyIsDown, secs, keyCode] = KbCheck;
            end

            while keyIsDown
                [keyIsDown, ~, ~] = KbCheck;
            end

        Distraction(Parameter); % süresini ayarlamak lazım %1dk olacak
        DrawFormattedText(Parameter.window, double('Bekleyiniz.'), 'center', 'center');
        Screen('Flip', Parameter.window);
        WaitSecs(3);
       end
       end

            
    %% Saving the data as struct  
    save study.mat 

end