%function Study(sub_id)
%function Study(Parameter, sub_id)
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

    %[studyList, newpairList] = listconstruction();

    Parameter = Preparescreen(); % düzelt burayı
    %Screen('TextSize', Parameter.window, 60); % => buna gerek olmayabilir


    fid = fopen("createdbyhand.txt", 'r' );
    all_pairs = textscan(fid, '%s%s', 'Delimiter','\t', 'TreatAsEmpty','~');
    fclose(fid);
    
    
        for i = 1:10
            Screen('DrawText', Parameter.window, all_pairs{1,1}{i},Parameter.centerX-150, Parameter.centerY, [255,255,255]);
            Screen('DrawText', Parameter.window, all_pairs{1,2}{i},Parameter.centerX+150, Parameter.centerY, [255,255,255]);
            Screen('Flip', Parameter.window);
            WaitSecs(1);
        end




            % save("Sub" + num2str(sub_id) + "\Sub" + ".mat");  ==>
            % kaydetme alternatifi


            % cumle kurmasini isteyecegim
                %Sound recording
      % recordSound() % bu fonksiyonu loopun i?inde kullanma?
            
        % kay?t i?in loopun i?ine d?zg?n yerle?tirmek laz?m, g?rd???
        % kelimeleri tekrar edip etmedi?ini d?zg?nce kaydetmek i?in
        
        %sub.record{1,j}{i} = recordSound(3); % her kelimeden sonra 3s ses kaydı koymus oldum
        % tusa basip bitti desin 
            % rt bundan sonra alinsin
            
            
            %movefile('sub.mat', Parameter.datadir); % num2str falan koy
            %  buraya
           
            save study.mat
            %distractoru buraya koy


        %end
    %end
  Screen('CloseAll')
%end