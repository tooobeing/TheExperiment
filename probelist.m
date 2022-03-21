function probelist(sub_id)
    % this function creates probe list for the test part
load sub.mat

    % simdi tek ve cift kelimeleri aliyor
    % basina bir condition koymak lazım bazen onu bazen oburunu alması
    % gerekiyor
    % bir katilimci icin tum listelerde tek veya cift mi almali yoksa
    % listeler arasi bu durum random mu olacak?
    f = fopen("probelisst.txt", 'a');
    [rows cols] = size(sub.word);

    % t1 field is 4th word from each list
    % t2 is 6th word from each list
    % will it be useful?
for i = 1:cols
    testPair.t1{i} = sub.word{1,i}{4}; % i indicates list
    testPair.t2{i} = sub.word{1,i}{6};
end


    a = randi(2);
    if a == 1
    for i = 1:cols
        fprintf(f, '%s\n', sub.word{1,i}{4});
        fprintf(f, '%s\n', sub.word{1,i}{6});
        fprintf(f, '%s\n', sub.word{1,i}{8});
    end
    
    elseif a == 2
    for i = 1:cols
        fprintf(f, '%s\n', sub.word{1,i}{3});
        fprintf(f, '%s\n', sub.word{1,i}{5});
        fprintf(f, '%s\n', sub.word{1,i}{7});
    end
    end

    fclose(f);
end

% new words de eklenecek + randomization of probelist
% new words icin bir liste olustur ve hep oradan cek