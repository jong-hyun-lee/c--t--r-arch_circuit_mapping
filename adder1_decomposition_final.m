%%adder1_decomposition
arch_cell = inputdlg('layout type 종류 (t-type = 1, c-type = 2)');
arch_num = str2double(arch_cell);
loop_input_cell = inputdlg('loop 수');
loop_input_num =str2double(loop_input_cell);


for loop =1: loop_input_num
    init_operation = {'MAJ' '1' '2' '3';
        'MAJ' '3' '4' '5';
        'MAJ' '5' '6' '7';
        'MAJ' '7' '8' '9';
        'MAJ' '9' '10' '11';
        'MAJ' '11' '12' '13';
        'MAJ' '13' '14' '15';
        'MAJ' '15' '16' '17';
        'C' '17' '18' '-';
        'UMA' '15' '16' '17';
        'UMA' '13' '14' '15';
        'UMA' '11' '12' '13';
        'UMA' '9' '10' '11';
        'UMA' '7' '8' '9';
        'UMA' '5' '6' '7';
        'UMA' '3' '4' '5';
        'UMA' '1' '2' '3'
        };
    init_operation2 = MAJ_UMA(init_operation);
    
    operation_cell_adder1 = Toffoli_decompostion(init_operation2);
    if arch_num == 2
        Sch_adder = Scheduling_operation(operation_cell_adder1, 'c-arch');
        fileID = fopen("Scheduled_add1_c_arch.txt", 'a');
        schduled_operation_size = size(Sch_adder);
        fprintf(fileID, 'arch : \tc-arch\n');
        fprintf(fileID, 'loop:\t%d\n', loop);
        for i = 1: schduled_operation_size(1)
            formatSpec2 = '%s\n';
            fprintf(fileID, formatSpec2, strjoin(Sch_adder(i,:)));
        end
        fprintf(fileID, '\n');
        fclose(fileID);       
        
    elseif arch_num==1
        Sch_adder = Scheduling_operation(operation_cell_adder1, 't-arch');
        fileID = fopen("Scheduled_add1_t_arch.txt", 'a');
        schduled_operation_size = size(Sch_adder);
        fprintf(fileID, 'arch : \tt-arch\n');
        fprintf(fileID, 'loop:\t%d\n', loop);
        for i = 1: schduled_operation_size(1)
            formatSpec2 = '%s\n';
            fprintf(fileID, formatSpec2, strjoin(Sch_adder(i,:)));
        end
        fprintf(fileID, '\n');
        fclose(fileID);       
    end
end
