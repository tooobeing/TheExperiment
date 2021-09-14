function Study(sub_id)
    % The Study function only displays the lists in the randomized fashion
    % The order of words/pairs in the lists will be remain the same
    % The function displays each word pairs, => done
    % asks participant to generate a sentence using the pair they see,=> to do
    % records generated sentences,=> to do
    % Keeps track of the study duration of each pairs,=> to do
    % and words that are studied. => to do

    Parameter = Preparescreen(sub_id);
    for i = 1:32
        listOpen = (['List' num2str(i) '.txt']);
        fid(i) = fopen(listOpen);
    end

    % creates a for loop for the different lists
    % Seven seperate lists will be displayed during the experiment
    randList = randperm(32); %randomize the lists to show
    for j = 1:7
        words(j) = textscan(fid(randList(j)), '%s');
        x = int2str(j);
        numofList = ['Liste', x];     
        Screen('DrawText', Parameter.window, numofList, Parameter.centerX, Parameter.centerY, [255 255 255]); %Gercek centerda gostermiyor 
        Screen('Flip', Parameter.window);                                                         %ciftleri gosterirken o sorunu hepten cozmek lazim
        WaitSecs(1); %sureyi ayarla + ses kaydi koymak lazim
        sub.list{j} = numofList; %tam olmadi

        %displays the words of the selected lists in the same order every time
        for i = 1:10 %hardcodingi kaldir
            c = words{1, j}{i};
           % c = double(c);
            Screen('DrawText', Parameter.window, c, Parameter.centerX, Parameter.centerY, [255 255 255]);
            sub.word{i} = c; % sadece son 10'u kaydediyor
            Screen('Flip', Parameter.window);
            WaitSecs(.1);
            time = GetSecs;
            
            save('sub', 'sub');
            movefile('sub.mat', Parameter.datadir);
            %RestrictKeysForKbCheck([KbName('z'), KbName('m')]);

            %keyIsDown = 0;
            %while keyIsDown == 0 
            %    [keysIsDown, ~,~] = KbCheck; %keep cheking until it is 1
            %end

            %while keyIsDown
            %    [keysIsDown, ~,~] = KbCheck;
            %end


        end
    end
    Screen('CloseAll')
end