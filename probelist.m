function probeList = probelist() % parameter olabilir içi
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
    save testPair.mat
%end

    % final list oluştur
    % i'ler liste sayısına göre değişmeli-parameter'ın içine koy ama sonra 
    % pairları ya ikinci row olarak yazdır ya da iki colomn yapmaya bak
    probeList = {};
    if a == 1
        for i = 1:3
            probeList{i} = testPair.t4{i};
            probeList{i+3} = testPair.t6{i};
            probeList{i+6} = testPair.t8{i};
            probeList{i+9} = testPair.tn{i};
        end
    elseif a == 2
        for i = 1:3
            probeList{i} = testPair.t3{i};
            probeList{i+3} = testPair.t5{i};
            probeList{i+6} = testPair.t7{i};
            probeList{i+9} = testPair.tn{i};
        end
    end

    
    Shuffle(probeList); % bunu bir variable'a ata
    
    end