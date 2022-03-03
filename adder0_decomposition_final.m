%%adder0_decomposition
arch_cell = inputdlg('layout type 종류 (t-type = 1, c-type = 2)');
arch_num = str2double(arch_cell);
loop_input_cell = inputdlg('loop 수');
loop_input_num =str2double(loop_input_cell);


for loop =1: loop_input_num
    init_operation = {'Carry_r' '1' '2' '3' '4';
    'Carry_r' '4' '5' '6' '7';
    'Carry_r' '7' '8' '9' '10';
    'Carry_r' '10' '11' '12' '13';
    'Carry_r' '13' '14' '15' '16';
    'C' '14' '15' '-' '-';
    'Sum' '13' '14' '15' '-';
    'Carry_l' '10' '11' '12' '13';
    'Sum' '10' '11' '12' '-';
    'Carry_l' '7' '8' '9' '10';
    'Sum' '7' '8' '9' '-';
    'Carry_l' '4' '5' '6' '7';
    'Sum' '4' '5' '6' '-';
    'Carry_l' '1' '2' '3' '4';
    'Sum' '1' '2' '3' '-'
};
init_operation2 = Carry_Sum(init_operation);
    
    operation_cell_adder1 = Toffoli_decompostion(init_operation2);
    if arch_num == 2
        Sch_adder = Scheduling_operation(operation_cell_adder1, 'c-arch');
        fileID = fopen("Scheduled_add0_c_arch.txt", 'a');
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
        fileID = fopen("Scheduled_add0_t_arch.txt", 'a');
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
