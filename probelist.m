function probelist(sub_id)    
load sub.mat
    % simdi tek ve cift kelimeleri aliyor
    % basina bir condition koymak lazım bazen onu bazen oburunu alması
    % gerekiyor
    % bir katilimci icin tum listelerde tek veya cift mi almali yoksa
    % listeler arasi bu durum random mu olacak?
    f = fopen("probelisst.txt", 'a');
    [rows cols] = size(sub.word);
    for i = 1:cols
        fprintf(f, '%s\n', sub.word{1,i}{4});
        fprintf(f, '%s\n', sub.word{1,i}{6});
        fprintf(f, '%s\n', sub.word{1,i}{8});
    end

    for i = 1:cols
        fprintf(f, '%s\n', sub.word{1,i}{3});
        fprintf(f, '%s\n', sub.word{1,i}{5});
        fprintf(f, '%s\n', sub.word{1,i}{7});
    end

    fclose(f);
end