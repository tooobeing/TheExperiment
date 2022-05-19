function RunExp(sub_id)
    % main function of the experiment
    % this function saves the data of each subject
    rand('state', sum(100*clock)); % for setting the seed randomly
   
    tic;   
    Parameter.sub_id = sub_id; 
    Parameter.datadir = ['../Data/Sub' num2str(Parameter.sub_id) '/'];

    % Check subject number
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
    

    % Prepare screen
    Parameter = Preparescreen(Parameter);
    % create study and test dat files
    Parameter.sub_id = sub_id;
    Parameter.datadir = ['../Data/Sub' num2str(Parameter.sub_id) '/'];
    Parameter.test_file = fopen(sprintf('Test_Sub%d.dat', Parameter.sub_id), 'a'); 
    Parameter.study_file = fopen(sprintf('Study_Sub%d.dat', Parameter.sub_id), 'a');
    
    HideCursor;
    % Instruction 
    instruction(Parameter);

    %% prepare randomization for study and test cycles
    randlist = randperm(10); % randomization of lists
    randword = randperm(10); % randomization of words within lists
    randprobe = randi(2); % randomization for probe list construction 1=even & 2=odd 
    randnew = randperm(40); % randomization for new pair 

    %% practice
    Studypractice(Parameter);
    Testpractice(Parameter);


    %% first cycle
    sub = Study1(Parameter, sub_id, randlist, randword);
    sub = Test1(Parameter, sub_id, sub, randprobe, randnew);
    
    %% rest
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
            

    %% second cycle
    sub = Study2(Parameter, sub_id, randlist, randword);
    sub = Test2(Parameter, sub_id, sub, randprobe, randnew);
        

    %% moving the data to the subject's file
    Parameter.datadir = ['../Data/Sub' num2str(Parameter.sub_id) '/'];
    %movefile(Parameter.study_file, Parameter.datadir);
    movefile(sprintf('Test_Sub%d.dat', Parameter.sub_id), Parameter.datadir);
    save workspace.mat;
    movefile('workspace.mat', Parameter.datadir);
    movefile('study1.mat', Parameter.datadir);
    movefile('test1.mat', Parameter.datadir);
    movefile('study2.mat', Parameter.datadir);
    movefile('test2.mat', Parameter.datadir);
    endText = 'Deney sona erdi. Katılımınız için teşekkür ederiz.';
    DrawFormattedText(Parameter.window, double(endText), 'center', 'center');
    Screen('Flip', Parameter.window);
    WaitSecs(3);
    Screen('CloseAll');
    ShowCursor;
    toc
    %ListenChar(1);
    %fprintf('Deney %d dakika sürdü \n', RT);
end