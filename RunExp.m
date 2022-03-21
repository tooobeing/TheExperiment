function RunExp(sub_id)
    % this function creates a struct for each subject to save their data
    % done -> runs Study 
    % to do -> Test 
    % to do -> distractor functions
    
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
    Parameter = Preparescreen();    


    % Instruction 
     instruction(Parameter);
    
    % run study function
    % write 'you will begin to study phase of the experiment'
   % Study(Parameter, sub_id);
    
    % run distractor
    % write 'now you will begin the mathematical calculation'
    
    % run test function
   % Test(sub_id);
    % buraya bir bak

    
    
    % Prepare screen   
    % bu iki satırı tekrar kopyalayınca çalıştı
    % ama yukarıdan da silemem belki böyle kalır
    Parameter.sub_id = sub_id; % problem cikiyor 
    Parameter.datadir = ['../Data/Sub' num2str(Parameter.sub_id) '/'];

    Parameter.test_file = fopen(sprintf('Data_Sub%d.dat', Parameter.sub_id), 'a'); % açıyor ama boş/bunu nasıl doldururuz
    % PrepareScreen çalıştırmayınca - çalışıyor
    % PrepareScreen çalışınca - hata veriyor



    Screen('CloseAll')
    %movefile(sprintf('Data_sub%d.dat', Parameter.sub_id), Parameter.datadir); % bunu yapamadı 
    % muhtemelen dosya boş olduğu için taşıyamıyor
    save('workspace');
    movefile('workspace.mat', Parameter.datadir);

toc
end