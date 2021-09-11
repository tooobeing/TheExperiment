%to save the data of the subject
%cd(['Sub' num2str(SubID)])
getResp = fopen('Test.dat' , 'a'); %creates a dat folder that contain the subject data
fprintf(getResp, '%s\t %s\t %s\t %s\t %s\t %s\t %s\n', 'testPosition', 'probe', 'CI', 'CIRT', 'response', 'listNo', 'wordNo'); %headers of the dat folder
fclose(getResp);