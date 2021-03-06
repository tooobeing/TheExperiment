function [studyList, newpairList] = listconstruction()
    % a big struct is constructed using first and second words in the pair
    % all rated word pairs are in one struct the pairs were shuffled in R program
    % now 10-pair word lists will be constructed
    fid = fopen("studyList_shuffled.txt", 'r' );
    all_pairs = textscan(fid, '%s%s', 'Delimiter','-', 'TreatAsEmpty','~');
    fclose(fid);    
    
    for j = 1:10 % for 10 lists
        studyList{j} = {};
        for i = ((j-1)*10+1):(j*10) % to manage to 
            k = i-10*(j-1);
            studyList{j}{k,1} = all_pairs{1,1}{i};       
            studyList{j}{k,2} = all_pairs{1,2}{i};
        end
    end    

%% all lists are created, then commented out
    % creates lists as txt files just for once
%     for j = 1:10
%         f = fopen("List" + num2str(j)+".txt", 'a');
%         for i = ((j-1)*10+1):(j*10) 
%             fprintf(f, '%s\t %s\n', all_pairs{1,1}{i}, all_pairs{1,2}{i});        
%         end
%         fclose(f);    
%     end

    
    %% new pairs
    % new-pairs list reading
    % new pairs for probe will be chosen from this list struct.
    fid_new = fopen("newPairs.txt", 'r');
    new_pairs = textscan(fid_new, '%s%s', 'Delimiter', '\t');
    fclose(fid_new);
    
    % new pairs struct   
    [rows cols] = size(new_pairs{1,1});
    for i = 1:rows
        newpairList{i,1} = new_pairs{1,1}{i};
        newpairList{i,2} = new_pairs{1,2}{i};
    end
end
