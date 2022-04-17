function RunExp(sub_id)
    % this function creates a struct for each subject to save their data
    % done -> runs Study 
    % done -> Test 
    % done -> distractor functions
    
    tic
   
    Parameter.sub_id = sub_id; % problem cikiyor 
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
     Demo.sex = input('Cinsiyetiniz? [K/E/D] ', 's');
   %  Demo.handedness = input('Solak m?s?n?z? [E/H] ', 's');
    % Demo.visual_problems = input('Herhangi bir g?rme probleminiz var m?? [E/H] ', 's');
    save('Demo', 'Demo');
    
    movefile('Demo.mat', Parameter.datadir); % move demo info to subject's data folder

    % Prepare screen
    Parameter = Preparescreen(Parameter);
    % create study and test dat files
    Parameter.sub_id = sub_id;
    Parameter.datadir = ['../Data/Sub' num2str(Parameter.sub_id) '/'];
    Parameter.test_file = fopen(sprintf('Test_Sub%d.dat', Parameter.sub_id), 'a'); 
    Parameter.study_file = fopen(sprintf('Study_Sub%d.dat', Parameter.sub_id), 'a');

    % Instruction 
    % instruction(Parameter);
    
    %% run study function
    sub = Study(Parameter, sub_id);
    
    % run distractor
    % write 'now you will begin the mathematical calculation'
    %Distraction(Parameter);
    
    %% run test function
    sub = Test(Parameter, sub_id);
    % buraya bir bak     


    Screen('CloseAll')
    Parameter.datadir = ['../Data/Sub' num2str(Parameter.sub_id) '/'];
    %movefile(sprintf('Study_Sub%d.dat', Parameter.sub_id), Parameter.datadir);
    %movefile(sprintf('Test_Sub%d.dat', Parameter.sub_id), Parameter.datadir);
    save('workspace');
    movefile('workspace.mat', Parameter.datadir);
    movefile('sub.mat', Parameter.datadir);

    toc
    %ListenChar(1);
    %fprintf('Deney %d dakika sürdü \n', RT);
end