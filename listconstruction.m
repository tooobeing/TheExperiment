% a big struct was constructed using first and second words in the pair
% listeler gelince hepsini böyle yap struct olarak kaydet tüm katılımcılar
% için böyle çeksin.

%Screen('Preference', 'SkipSyncTests', 1);
%[myW, rect] = Screen('OpenWindow', 0);
%centerX = rect(3)/2;
%centerY = rect(4)/2;

fid = fopen("shuffled1st.txt", 'r');
first = textscan(fid, '%s');
fclose(fid);

fid2 = fopen("shuffled2nd.txt", 'r');
second = textscan(fid2, '%s');
fclose(fid2);


%bunun üzerine düşün
pairs = {first{1,1}, second{1,1}};
for i = 1:10
    fieldname = sprintf('List%i', i);
    for j = 1:10
    
    AllList.fieldname{1,1}{j} = pairs{1,1}{j};
    end
end




%for i = 1:3
 %   Screen('DrawText', myW, pairs{1,1}{i},centerX-50, centerY, [0,0,0]);
  %  Screen('DrawText', myW, pairs{1,2}{i},centerX+50, centerY, [0,0,0]);
   % Screen('Flip', myW);
    %WaitSecs(1);
%end



%Screen('CloseAll');