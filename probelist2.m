function [randProbeList testPair] = probelist2(sub, randprobe, randnew)
    % this function creates probe list for the test part
    %load study.mat % bunu dat'tan çekmek daha iyi olabilir
    Parameter.numoflist = 5; % for 2 study-test cycles
    [studyList, newpairList] = listconstruction();
    %Parameter = Preparescreen();
    [rows cols] = size(sub.word);
    
    % t's indicates word's ranking within the list
    % t4 has 4th words from all presented lists and goes on like that
    % a is for randomization, for different participants even or odd'th probes
    % will be presented
        if randprobe == 1
            for i = 6:cols
                testPair.t4{i-5,1} = sub.word{1,i}{4,1}; % i indicates list
                testPair.t4{i-5,2} = sub.word{1,i}{4,2};
                testPair.t6{i-5,1} = sub.word{1,i}{6,1};
                testPair.t6{i-5,2} = sub.word{1,i}{6,2};
                testPair.t8{i-5,1} = sub.word{1,i}{8,1};
                testPair.t8{i-5,2} = sub.word{1,i}{8,2};
            end
        else 
            for i = 6:cols
                testPair.t3{i-5,1} = sub.word{1,i}{3,1};
                testPair.t3{i-5,2} = sub.word{1,i}{3,2};
                testPair.t5{i-5,1} = sub.word{1,i}{5,1};
                testPair.t5{i-5,2} = sub.word{1,i}{5,2};
                testPair.t7{i-5,1} = sub.word{1,i}{7,1};
                testPair.t7{i-5,2} = sub.word{1,i}{7,2};
            end
        end
    
    % new pairs from a different list
    fid_new = fopen("newPairs.txt", 'r');
    new_pairs = textscan(fid_new, '%s%s', 'Delimiter', '\t');
    fclose(fid_new);
     
    for i = 6:10
    %randnew = randperm(10); 
    %for i = 1:10
        testPair.tn{i-5,1} = new_pairs{1,1}{randnew(i)};
        testPair.tn{i-5,2} = new_pairs{1,2}{randnew(i)};
    end

    % save the test pairs struct to sub
   sub.testPair = testPair;

% probe list is constructed from test pairs 
    probeList = {};
    if randprobe == 1
        for i = 1:Parameter.numoflist 
            probeList{i,1} = testPair.t4{i,1};
            probeList{i,2} = testPair.t4{i,2};
            probeList{i+Parameter.numoflist,1} = testPair.t6{i,1};
            probeList{i+Parameter.numoflist,2} = testPair.t6{i,2};
            probeList{i+2*Parameter.numoflist,1} = testPair.t8{i,1};
            probeList{i+2*Parameter.numoflist,2} = testPair.t8{i,2};
            probeList{i+3*Parameter.numoflist,1} = testPair.tn{i,1}; 
            probeList{i+3*Parameter.numoflist,2} = testPair.tn{i,2};
        end
    elseif randprobe == 2
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

    
    % Randomization of selected probes
      [rows ~] = size(probeList);
      rand = randperm(20);
      randProbeList = {};
      for j = 1:rows
          randProbeList{j,1} = probeList{rand(j),1};
          randProbeList{j,2} = probeList{rand(j),2};
      end
    end