function RunExp(sub_id)
    % this function creates a struct for each subject to save their data
    % done -> runs Study 
    % to do -> Test 
    % to do -> distractor functions
    
    tic
    sub.id = sub_id;
    %Parameter = Preparescreen(sub_id);
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
%     Demo.sex = input('Cinsiyetiniz? [K/E/D] ', 's');
%     Demo.handedness = input('Solak m?s?n?z? [E/H] ', 's');
%     Demo.visual_problems = input('Herhangi bir g?rme probleminiz var m?? [E/H] ', 's');
    save('Demo', 'Demo');
    
    movefile('Demo.mat', Parameter.datadir);
    
    % add instruction 
    
    
    % run study function
    % write 'you will begin to study phase of the experiment'
    Study(sub_id);
    
    % run distractor
    % write 'now you will begin the mathematical calculation'
    
    % run test function
    Test(sub_id);
    % buraya bir bak
    textTest = 'Test a?amas?na ge?mek i?in bo?luk tu?una bas?n';
    DrawFormattedText(Parameter.window, textTest, 'center', 0, 255);
    Screen('Flip', Parameter.window);
    WaitSecs(2)
    
    
    % Prepare screen
   % Parameter = Preparescreen();
    %Parameter.test_file = fopen(sprintf('Data_Sub%d.dat', Parameter.sub_id), 'a'); %fieldde sikinti cikariyor
    


%to save the data of the subject
%cd(['Sub' num2str(SubID)])
% getResp = fopen('Test.dat' , 'a'); %creates a dat folder that contain the subject data
% fprintf(getResp, '%s\t %s\t %s\t %s\t %s\t %s\t %s\n', 'testPosition', 'probe', 'CI', 'CIRT', 'response', 'listNo', 'wordNo'); %headers of the dat folder
% fclose(getResp);



toc
end