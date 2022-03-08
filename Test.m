function Test(sub_id)   
    probelist(sub_id);
    % buraya bir bak
    Parameter = Preparescreen(sub_id);
    Study(sub_id);
           
   
    
    DrawFormattedText(Parameter.window, double(sprintf('Test aşamasına geçmek için boşluk tuşuna basın')), 'center', 'center');
    Screen('Flip', Parameter.window);
    WaitSecs(2);
        %textTest = 'Test aşamasına geçmek için boşluk tuşuna basın';
        %DrawFormattedText(Parameter.window, textTest, 'center', 0, 0);
        %Screen('Flip', Parameter.window);
        %WaitSecs(2)
         f = fopen('probelisst.txt', 'r');
         scanprobelist = textscan(f, '%s');
    fclose(f); % cannot close the probelist
    [rows cols] = size(scanprobelist{1,1});
    for i = 1:rows
        pairs = scanprobelist{1,1}{i};
        Screen('DrawText', Parameter.window, pairs, Parameter.centerX, Parameter.centerY, [255 255 255] );
        Screen('Flip', Parameter.window);
        WaitSecs(0.5);
        sprintf('%s', scanprobelist{1,1}{i});
    end

    % farklı fonksiyonları birleştirince iki pencere açıp ayrı ayrı
    % çalıştırıyor, teoride çalışıyor.
    % zaten başlangıçta iki kere openwindow çalışıyor onu da çözmek lazım

   
    
     Screen('Closeall');
end
