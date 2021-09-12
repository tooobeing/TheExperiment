function RunExp(sub_id)
    tic
    Parameter.sub_id = sub_id;
    Parameter.datadir = ['../Data/Sub' num2str(Parameter.sub_id) '/'];

    % Check subject number
    % bunu bir kontrol et
    if exist(Parameter.datadir) == 7
        msg = double(msgbox('Ba?ka bir kat?l?mc? numaras? deneyin.', 'Error!'));
        uiwait(msg);
        return;
    else
        mkdir(Parameter.datadir); %create folder
    end

    %Demographics
    Demo.age = double(input('Ya??n?z? '));
    Demo.sex = input('Cinsiyetiniz? [K/E/D] ', 's');
    Demo.handedness = input('Solak m?s?n?z? [E/H] ', 's');
    Demo.visual_problems = input('Herhangi bir g?rme probleminiz var m?? [E/H] ', 's');
    save('Demo', 'Demo');
    
    movefile('Demo.mat', Parameter.datadir);
    
    % Prepare screen
    Parameter = Preparescreen();
    Parameter.test_file = fopen(sprintf('Data_Sub%d.dat', Parameter.sub_id), 'a'); %fieldde sikinti cikariyor
    


%to save the data of the subject
%cd(['Sub' num2str(SubID)])
getResp = fopen('Test.dat' , 'a'); %creates a dat folder that contain the subject data
fprintf(getResp, '%s\t %s\t %s\t %s\t %s\t %s\t %s\n', 'testPosition', 'probe', 'CI', 'CIRT', 'response', 'listNo', 'wordNo'); %headers of the dat folder
fclose(getResp);



toc
end