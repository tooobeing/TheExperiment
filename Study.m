%function Study(sub_id)
function Study(Parameter, sub_id)
    % The Study function only displays the lists in the randomized fashion
    % The order of words/pairs in the lists will remain the same
    % The function displays each word pairs, => done
    % words are presented after key press => done
    % asks participant to generate a sentence using the pair they see,=> done
    % records generated sentences,=> to do
    % Keeps track of the study duration of each pairs,=> done 
    % for when key is pressed
    % and words that are studied. => done 
    % records which words are studied in sub struct

    [studyList, newpairList] = listconstruction(sub_id);

    %Parameter = Preparescreen(); % düzelt burayı

    %% List presentation 
    % Ten or five seperate lists will be displayed during the experiment
    rand = randperm(10); % randomization of lists
   for j = 1:10 % 10|5 olacak        
        whichList = int2str(j);
        numofList = ['Liste ', whichList];
        DrawFormattedText(Parameter.window, numofList, 'center', 'center');
        %Screen('DrawText', Parameter.window, numofList, Parameter.centerX, Parameter.centerY, [255 255 255]); %Gercek centerda gostermiyor 
        Screen('Flip', Parameter.window);                                                         %ciftleri gosterirken o sorunu hepten cozmek lazim
        WaitSecs(1); %sureyi ayarla + ses kaydi koymak lazim
        %sub(sub_id).list{j} = numofList; %tam olmadi


        %displays the words of the selected lists in the same order every time        
        [rows cols] = size(studyList{1,1});  
        


        for i = 1:rows
            %[normBoundsRect1, ~] = Screen('TextBounds', Parameter.window, studyList{i,1}); %kullanınca screen hatası veriyor
            %[normBoundsRect2, ~] = Screen('TextBounds', Parameter.window, studyList{i,2});
            Screen('DrawText', Parameter.window, studyList{1, rand(j)}{i,1}, Parameter.centerX1, Parameter.centerY, [255 255 255]);
            Screen('DrawText', Parameter.window, studyList{1, rand(j)}{i,2}, Parameter.centerX2, Parameter.centerY, [255 255 255]);
            % presented word-pair is recorded, j represents the list, i is the word
            sub.word{j}{i,1} = studyList{1, rand(j)}{i,1}; 
            sub.word{j}{i,2} = studyList{1, rand(j)}{i,2};            
            preFlip = Screen('Flip', Parameter.window);

            % waits for subject to press the space bar to see the next word-pair
            % baska tus yap sonrasında 
            RestrictKeysForKbCheck([Parameter.space]);          
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
        DrawFormattedText(Parameter.window, textaritmetik, 'center', 'center');
        Screen('Flip', Parameter.window);
            RestrictKeysForKbCheck([Parameter.space]);          
            keyIsDown = 0;
            while keyIsDown == 0
                [keyIsDown, secs, keyCode] = KbCheck;
            end

            while keyIsDown
                [keyIsDown, ~, ~] = KbCheck;
            end

        %Distraction(Parameter); % süresini ayarlamak lazım %1dk olacak
    end
            
    %% Saving the data
            save sub.mat
            %Parameter.datadir = ['../Data/Sub' num2str(Parameter.sub_id) '/'];
            %movefile('sub.mat', Parameter.datadir); % num2str falan koy
            %movefile(Parameter.study_file, Parammeter.datadir);
            %  buraya
           
            save study.mat
        %end
    %end
  %Screen('CloseAll');
end