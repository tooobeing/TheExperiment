%function Study(sub_id)
function Study( sub_id)
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

    [studyList, newpairList] = listconstruction();

    Parameter = Preparescreen(); % düzelt burayı
    %Screen('TextSize', Parameter.window, 60); % => buna gerek olmayabilir

    
    snames = fieldnames(studyList);
    for s = 1:numel(snames)
        aa = studyList.(snames{s});
        Screen('DrawText', Parameter.window, snames{s}, Parameter.centerX, Parameter.centerY, [0,0,0]);
        Screen('Flip', Parameter.window);
        WaitSecs(1);
        for i = 1:10
            Screen('DrawText', Parameter.window, aa{i,1},Parameter.centerX-50, Parameter.centerY, [0,0,0]);
            Screen('DrawText', Parameter.window, aa{i,2},Parameter.centerX+50, Parameter.centerY, [0,0,0]);
            Screen('Flip', Parameter.window);
            WaitSecs(1);
        end
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
end