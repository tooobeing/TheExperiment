function RunExp(sub_id)
    % main function of the experiment
    % this function saves the data of each subject
    rand('state', sum(100*clock)); % for setting the seed randomly

    
    tic;   
    Parameter.sub_id = sub_id; 
    Parameter.datadir = ['../Data/Sub' num2str(Parameter.sub_id) '/'];

    % Check subject number
    % bunu bir kontrol et
    if exist(Parameter.datadir) == 7
        msg = double(msgbox('Başka bir katılımcı numarası deneyin.', 'Error!'));
        uiwait(msg);
        return;
    else
        mkdir(Parameter.datadir); %create folder 
    end

    %Demographics
     Demo.age = double(input('Ya??n?z? '));
     %Demo.sex = input('Cinsiyetiniz? [K/E/D] ', 's');
     %Demo.handedness = input('Hangi elinizi baskın olarak kullanıyorsunuz? [L/R] ', 's');
     %Demo.visual_problems = input('Herhangi bir görme probleminiz var m?? [E/H] ', 's');
     save('Demo', 'Demo');
    
    movefile('Demo.mat', Parameter.datadir); % move demo info to subject's data folder
    
    %subMaster.sub_id = sub_id;
    % Prepare screen
    Parameter = Preparescreen(Parameter);
    % create study and test dat files
    Parameter.sub_id = sub_id;
    Parameter.datadir = ['../Data/Sub' num2str(Parameter.sub_id) '/'];
    Parameter.test_file = fopen(sprintf('Test_Sub%d.dat', Parameter.sub_id), 'a'); 
    Parameter.study_file = fopen(sprintf('Study_Sub%d.dat', Parameter.sub_id), 'a');

    % Instruction 
    %instruction(Parameter);
    randlist = randperm(10); % randomization of lists
    randword = randperm(10); % randomization of words within lists
    for cycle = 1:2 % Experiment consist of 2 study-test cycles
        %% run study function
        subMaster = Study(Parameter, sub_id,cycle, randlist, randword);
        % distractor runs in the Study function
        %% run test function
        Test(Parameter, sub_id, subMaster);
        % buraya bir bak 
        restText = 'Deneye biraz ara verebilirsiniz. \n Hazır olduğunuzda boşluk tuşuna basarak devam edin.';
        DrawFormattedText(Parameter.window, double(restText), 'center', 'center');
        Screen('Flip', Parameter.window);
        RestrictKeysForKbCheck([Parameter.space]);          
        keyIsDown = 0;
        while keyIsDown == 0
            [keyIsDown, secs, keyCode] = KbCheck;
        end        
        while keyIsDown
            [keyIsDown, ~, ~] = KbCheck;
        end
    end


    
    Parameter.datadir = ['../Data/Sub' num2str(Parameter.sub_id) '/'];
    %movefile(Parameter.study_file, Parameter.datadir);
    %movefile(sprintf('Test_Sub%d.dat', Parameter.sub_id), Parameter.datadir);
    save workspace.mat;
    movefile('workspace.mat', Parameter.datadir);
    movefile('study.mat', Parameter.datadir);
    movefile('test.mat', Parameter.datadir);
    endText = 'Deney sona erdi. Katılımınız için teşekkür ederiz.';
    DrawFormattedText(Parameter.window, double(endText), 'center', 'center');
    Screen('Flip', Parameter.window);
    WaitSecs(3);
    Screen('CloseAll');

    toc
    %ListenChar(1);
    %fprintf('Deney %d dakika sürdü \n', RT);
end