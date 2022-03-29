% a big struct was constructed using first and second words in the pair
% listeler gelince hepsini böyle yap struct olarak kaydet tüm katılımcılar
% için böyle çeksin.

%Screen('Preference', 'SkipSyncTests', 1);
%[myW, rect] = Screen('OpenWindow', 0);
%centerX = rect(3)/2;
%centerY = rect(4)/2;

% all rated word pairs are in one struct
% the pairs were shuffled in R program
% now 10-pair word lists will be constructed
fid = fopen("studyList_shuffled.txt", 'r' );
all_pairs = textscan(fid, '%s%s', 'Delimiter','-', 'TreatAsEmpty','~');
fclose(fid);



field_names = {'List1', 'List2', 'List3', 'List4', 'List5', 'List6', 'List7', 'List8', 'List9', 'List10'};


all_pairs{1,1}
values = {'List1', 'List2', 'List3', 'List4', 'List5', 'List6', 'List7', 'List8', 'List9', 'List10'};



% 10 tane liste yapıyor ama aynı kelimeleri kopyalıyor 
% bir de liste ismi eklemeye çalışacağım ve farklı listeler oluşturmaya
for j = 1:10
    values{j} = {};
    counter = 0;
    for i = 1:10        
        values{j}{counter+i,1} = all_pairs{1,1}{counter+i};
        values{j}{counter+i,2} = all_pairs{1,2}{counter+i};
    end
    counter = 10;
end

    


%for i = 1:3
 %   Screen('DrawText', myW, pairs{1,1}{i},centerX-50, centerY, [0,0,0]);
  %  Screen('DrawText', myW, pairs{1,2}{i},centerX+50, centerY, [0,0,0]);
   % Screen('Flip', myW);
    %WaitSecs(1);
%end



%Screen('CloseAll');