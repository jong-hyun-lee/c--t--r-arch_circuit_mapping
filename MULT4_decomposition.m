%%adder1_decomposition
arch_cell = inputdlg('layout type 종류 (t-type = 1, c-type = 2)');
arch_num = str2double(arch_cell);
loop_input_cell = inputdlg('loop 수');
loop_input_num =str2double(loop_input_cell);


for loop =1: loop_input_num
    operation_cell_init= {
        'C_adder' '1' '5' '6' '7' '8' '9' '10' '11' '12' '13' '14' '15' '16' '17' '18' '19' '20' '21';
        'Rot1' '7' '9' '11' '13' '15' '17' '19' '21' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-';
        'C_adder' '2' '5' '6' '7' '8' '9' '10' '11' '12' '13' '14' '15' '16' '17' '18' '19' '20' '21';
        'Rot1' '7' '9' '11' '13' '15' '17' '19' '21' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-';
        'C_adder' '3' '5' '6' '7' '8' '9' '10' '11' '12' '13' '14' '15' '16' '17' '18' '19' '20' '21';
        'Rot1' '7' '9' '11' '13' '15' '17' '19' '21' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-';
        'C_adder' '4' '5' '6' '7' '8' '9' '10' '11' '12' '13' '14' '15' '16' '17' '18' '19' '20' '21';
        'Rot3' '7' '9' '11' '13' '15' '17' '19' '21' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-'
        };
    controlled_adder_decomposed = Controlled_adder(operation_cell_init);
    CMAJ_CUMA_decomposed = CMAJ_CUMA_Decomposition(controlled_adder_decomposed);
    
    Rot_decomposed = Rotation_decompostion(CMAJ_CUMA_decomposed);
    
    operation_cell = Toffoli_decompostion(Rot_decomposed);
    if arch_num == 2
        Sch_adder = Scheduling_operation(operation_cell, 'c-arch');
        fileID = fopen("Scheduled_MULT4_c_arch.txt", 'a');
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
        Sch_adder = Scheduling_operation(operation_cell, 't-arch');
        fileID = fopen("Scheduled_MULT4_t_arch.txt", 'a');
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
