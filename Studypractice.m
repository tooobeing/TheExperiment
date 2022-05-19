% This is study for practice part of the experiment
% study list is predetermined for each participant 
% and data saving is not necessary
function [sub] = Studypractice(Parameter)
    Screen('TextSize', Parameter.window, 60);
    % prepare the small study list for practice session
    list1 = {'a', 'b'; 'c', 'd'};
    list2 = {'e', 'f'; 'g', 'h'};
    list3 = {'x', 'y'; 'z', 't'};
    practiceList = {list1, list2, list3};
    
    %% List presentation 
    % First five seperate lists will be displayed during the experiment    
    [rows cols] = size(practiceList{1,1}); % determining size of the studyList to prevent hardcoding

    for j = 1:3 % 5 lists        
            whichList = int2str(j);
            numofList = ['Liste ', whichList];
            DrawFormattedText(Parameter.window, numofList, 'center', 'center');
            Screen('Flip', Parameter.window);                            
            WaitSecs(1); %sureyi ayarla + ses kaydi koymak lazim

        % displays the words of the selected lists
        % word-pairs randomized within lists                
        for i = 1:rows
            Screen('DrawText', Parameter.window, double(practiceList{1, j}{i,1}), Parameter.centerX1-100, Parameter.centerY, [255 255 255]);
            Screen('DrawText', Parameter.window, double(practiceList{1, j}{i,2}), Parameter.centerX2-100, Parameter.centerY, [255 255 255]);        
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

        Distraction(Parameter); % distractor
        % show blank screen
        DrawFormattedText(Parameter.window, double('Bekleyiniz.'), 'center', 'center');
        Screen('Flip', Parameter.window);
        WaitSecs(15); % blank screen duration
    end     
end