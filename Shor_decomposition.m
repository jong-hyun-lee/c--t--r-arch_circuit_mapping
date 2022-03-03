clc
clear
%%adder0_decomposition
arch_cell = inputdlg('layout type 종류 (t-type = 1, c-type = 2)');
arch_num = str2double(arch_cell);
loop_input_cell = inputdlg('loop 수');
loop_input_num =str2double(loop_input_cell);


for loop =1: loop_input_num
    operation_cell_init = {'I' '1' '1' '1';'I' '2' '2' '2';'I' '3' '3' '3';'I' '4' '4' '4';'I' '5' '5' '5';'I' '6' '6' '6';
        'To' '1'  '4' '5'; %'To' '1'  '5' '4'; 'To' '1'  '4' '5';
        'To' '1'  '3' '4'; 'To' '1'  '4' '3'; 'To' '1'  '3' '4';
        'To' '1'  '3' '6'; 'To' '1'  '6' '3'; 'To' '1'  '3' '6';
        'To' '2'  '3' '5'; 'To' '2'  '5' '3'; 'To' '2'  '3' '5';
       'To' '2'  '4' '6'; 'To' '2'  '6' '4'; 'To' '2'  '4' '6';
        };
    %operation_cell = Toffoli_decompostion(operation_cell_init);
    
    operation_cell_Shor = Toffoli_decompostion(operation_cell_init);
    if arch_num == 2
        Sch_Shor = Scheduling_operation(operation_cell_Shor, 'c-arch');
        fileID = fopen("Scheduled_shor_c_arch.txt", 'a');
        schduled_operation_size = size(Sch_Shor);
        fprintf(fileID, 'arch : \tc-arch\n');
        fprintf(fileID, 'loop:\t%d\n', loop);
        for i = 1: schduled_operation_size(1)
            formatSpec2 = '%s\n';
            fprintf(fileID, formatSpec2, strjoin(Sch_Shor(i,:)));
        end
        fprintf(fileID, '\n');
        fclose(fileID);       
        
    elseif arch_num==1
        Sch_Shor = Scheduling_operation(operation_cell_Shor, 't-arch');
        fileID = fopen("Scheduled_shor_t_arch.txt", 'a');
        schduled_operation_size = size(Sch_Shor);
        fprintf(fileID, 'arch : \tt-arch\n');
        fprintf(fileID, 'loop:\t%d\n', loop);
        for i = 1: schduled_operation_size(1)
            formatSpec2 = '%s\n';
            fprintf(fileID, formatSpec2, strjoin(Sch_Shor(i,:)));
        end
        fprintf(fileID, '\n');
        fclose(fileID);       
    end
end
