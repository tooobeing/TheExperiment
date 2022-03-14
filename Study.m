function Study(Parameter, sub_id)
    % The Study function only displays the lists in the randomized fashion
    % The order of words/pairs in the lists will remain the same
    % The function displays each word pairs, => done
    % words are presented after key press => done
    % asks participant to generate a sentence using the pair they see,=> to do
    % records generated sentences,=> to do
    % Keeps track of the study duration of each pairs,=> done 
    % for when key is pressed
    % and words that are studied. => done 
    % records which words are studied in sub struct

    %Parameter = Preparescreen(sub_id); % düzelt burayı
    Screen('TextSize', Parameter.window, 60); % => buna gerek olmayabilir
    for i = 1:32 % num of lists will be changed
        listOpen = (['List' num2str(i) '.txt']);
        fid(i) = fopen(listOpen);
    end

    % creates a for loop for the different lists
    % Seven seperate lists will be displayed during the experiment

    % hangi listeyi gösterdiğimizi biliyor muyuz?
    randList = randperm(32); %randomize the lists to show
    sub.listorder = randList; % to keep track of the lists are presented to the participant
    for j = 1:2 % 7 olacak
        words(j) = textscan(fid(randList(j)), '%s');
        whichList = int2str(j);
        numofList = ['Liste ', whichList];        
        Screen('DrawText', Parameter.window, numofList, Parameter.centerX, Parameter.centerY, [255 255 255]); %Gercek centerda gostermiyor 
        Screen('Flip', Parameter.window);                                                         %ciftleri gosterirken o sorunu hepten cozmek lazim
        WaitSecs(1); %sureyi ayarla + ses kaydi koymak lazim
        sub.list{j} = numofList; %tam olmadi

        %displays the words of the selected lists in the same order every time
        for i = 1:10 %hardcodingi kaldir
            c = words{1, j}{i};
           % c = double(c);
            Screen('DrawText', Parameter.window, c, Parameter.centerX, Parameter.centerY, [255 255 255]);
            sub.word = words; % sadece son 10'u kaydediyor
            Screen('Flip', Parameter.window);
            
            % waits for subject to press the space bar to see the next
            % word-pair
            % baska tus yap sonrasında %
            RestrictKeysForKbCheck([Parameter.space]);
            keyIsDown = 0;
            while keyIsDown == 0
                [keyIsDown, secs, keyCode] = KbCheck;
            end

            while keyIsDown
                [keyIsDown, ~, ~] = KbCheck;
            end


            
            % cumle kurmasini isteyecegim
                %Sound recording
      % recordSound() % bu fonksiyonu loopun i?inde kullanma?
            
        % kay?t i?in loopun i?ine d?zg?n yerle?tirmek laz?m, g?rd???
        % kelimeleri tekrar edip etmedi?ini d?zg?nce kaydetmek i?in
        
        %sub.record{1,j}{i} = recordSound(3); % her kelimeden sonra 3s ses kaydı koymus oldum
        % tusa basip bitti desin 
            % rt bundan sonra alinsin
            
            time = GetSecs;
            sub.RT{1,j}{i} = time; % tum RTleri kaydediyor
            
            % ses dosyasini da kaydet
            
            save('sub', 'sub');
            %movefile('sub.mat', Parameter.datadir);
           
            save study.mat


        end
    end
  %Screen('CloseAll')
end