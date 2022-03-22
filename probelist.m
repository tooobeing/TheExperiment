%function probelist(sub_id)
    % this function creates probe list for the test part
load sub.mat % farklı subjectlerin farklı sub.matları mı olsa buna bir bak

    
    [rows cols] = size(sub.word);

% t's indicates word's ranking within the list
% t4 has 4th words from all presented lists and goes on like that
% a is for randomization, for different participants even or odd'th probes
% will be presented
    a = randi(2);
    if a == 1
        for i = 1:cols
            testPair.t4{i} = sub.word{1,i}{4}; % i indicates list
            testPair.t6{i} = sub.word{1,i}{6};
            testPair.t8{i} = sub.word{1,i}{8};
        end
    else 
        for i = 1:cols
            testPair.t3{i} = sub.word{1,i}{3};
            testPair.t5{i} = sub.word{1,i}{5};
            testPair.t7{i} = sub.word{1,i}{7};
        end
    end

    % new pairs from a different list
    fid = fopen("NewWords.txt", 'r');
    newWords = textscan(fid, '%s');
    fclose(fid);
    nnew = Shuffle(newWords{1,1});
    for i = 1:10
        testPair.tn{i} = nnew{i,1};
    end


    % final list oluştur
    probelist = [];
    for j = 1:4
        for i = 1:10
            testPair{1,j}.t{j} = ;
        end
    end

% new words de eklenecek + randomization of probelist
% new words icin bir liste olustur ve hep oradan cek