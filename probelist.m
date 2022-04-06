function probeList = probelist() % parameter olabilir içi
    % this function creates probe list for the test part
%load sub.mat % farklı subjectlerin farklı sub.matları mı olsa buna bir bak
load study.mat
    
[studyList, newpairList] = listconstruction();
%Parameter = Preparescreen();
    [rows cols] = size(sub.word);

% t's indicates word's ranking within the list
% t4 has 4th words from all presented lists and goes on like that
% a is for randomization, for different participants even or odd'th probes
% will be presented
    a = randi(2);    
    if a == 1
        for i = 1:cols
            testPair.t4{i,1} = sub.word{1,i}{4,1}; % i indicates list
            testPair.t4{i,2} = sub.word{1,i}{4,2};
            testPair.t6{i,1} = sub.word{1,i}{6,1};
            testPair.t6{i,2} = sub.word{1,i}{6,2};
            testPair.t8{i,1} = sub.word{1,i}{8,1};
            testPair.t8{i,2} = sub.word{1,i}{8,2};
        end
    else 
        for i = 1:cols
            testPair.t3{i,1} = sub.word{1,i}{3,1};
            testPair.t3{i,2} = sub.word{1,i}{3,2};
            testPair.t5{i,1} = sub.word{1,i}{5,1};
            testPair.t5{i,2} = sub.word{1,i}{5,2};
            testPair.t7{i,1} = sub.word{1,i}{7,1};
            testPair.t7{i,2} = sub.word{1,i}{7,2};
        end
    end

    % new pairs from a different list
    fid_new = fopen("newPairs.txt", 'r');
    new_pairs = textscan(fid_new, '%s%s', 'Delimiter', '\t');
    fclose(fid_new);
    %new_pairs = Shuffle(new_pairs{1,1}); % bunu yapınca batıyor
    for i = 1:10
        testPair.tn{i,1} = new_pairs{1,1}{i};
        testPair.tn{i,2} = new_pairs{1,2}{i};
    end
   % save testPair.mat
%end


%%% biraz daha bak
    % final list oluştur
    % i'ler liste sayısına göre değişmeli-parameter'ın içine koy ama sonra 
    % pairları ya ikinci row olarak yazdır ya da iki colomn yapmaya bak
    probeList = {};
    if a == 1
        for i = 1:Parameter.numoflist  % bir ara olmuştu da yeniden bak
            probeList{i,1} = testPair.t4{i,1};
            probeList{i,2} = testPair.t4{i,2};
            probeList{i+Parameter.numoflist,1} = testPair.t6{i,1};
            probeList{i+Parameter.numoflist,2} = testPair.t6{i,2};
            probeList{i+2*Parameter.numoflist,1} = testPair.t8{i,1};
            probeList{i+2*Parameter.numoflist,2} = testPair.t8{i,2};
            probeList{i+3*Parameter.numoflist,1} = testPair.tn{i,1}; 
            probeList{i+3*Parameter.numoflist,2} = testPair.tn{i,2};
        end
    elseif a == 2
        for i = 1:Parameter.numoflist
            probeList{i,1} = testPair.t3{i,1};
            probeList{i,2} = testPair.t3{i,2};
            probeList{i+Parameter.numoflist,1} = testPair.t5{i,1};
            probeList{i+Parameter.numoflist,2} = testPair.t5{i,2};
            probeList{i+2*Parameter.numoflist,1} = testPair.t7{i,1};
            probeList{i+2*Parameter.numoflist,2} = testPair.t7{i,2};
            probeList{i+3*Parameter.numoflist,1} = testPair.tn{i,1}; 
            probeList{i+3*Parameter.numoflist,2} = testPair.tn{i,2};
        end
    end

    
  x =  Shuffle(probeList); % çiftleri bozuyor
    
    end