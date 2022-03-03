clc
clear
%% output은 Routed Operation
%% Input 은 알고리즘 종류, layout, placement 종류, loop 수
%window_size = 50;

algor_type = inputdlg('algorithm type 종류 ([[7,1,3]] = 1, [[15,1,3]] = 2, test_algorithm = 3, Shor(15) = 4, Adder0 = 5, Adder1 = 6, MULT4 = 7');
arch_cell = inputdlg('layout type 종류 (t-type = 1, c-type = 2, proposal1 = 3)');
intial_placement_cell = inputdlg('placement 종류 (ref = 1, my_init = 2) \n t-arch,c-arch의 경우, ref는 min_manhattan, my_init은 저장해 온것을 불러옴을 의미 \n proposal의 경우 ref는 min manhattan, my_init은 sorting 알고리즘을 의미');
window_size_cell = inputdlg('window_size : ');
loop_input_cell = inputdlg('loop 수');

algor_type_num = str2double(algor_type);
arch_num = str2double(arch_cell);
intial_placement_input_num =str2double(intial_placement_cell);
loop_input_num =str2double(loop_input_cell);
window_size = str2double(window_size_cell);
%% archtecture를 받음
if arch_num == 1
    arch ='t-arch'
elseif arch_num==2
    arch ='c-arch'
elseif arch_num==3
    arch = 'prop_1'
end

if intial_placement_input_num==1
    place_type ='ref'
elseif intial_placement_input_num==2
    place_type ='mine'
end

[cycles_Init,cycles_H,cycles_CNOT,cycles_SWAP,cycles_P, cycles_T] = all_operaiton_time(arch);

%% algorithm 을 불러 옴 p, t 는 P_conju, T_conju
if algor_type_num == 1  % [[7,1,3]] encoding 의 경우
    operation_cell ={'I' '1' '1';'I' '2' '2';'I' '3' '3';'I' '4' '4';'I' '5' '5';'I' '6' '6';'I' '7' '7';'I' '8' '8';'I' '9' '9';
        'H' '1' '1'; 'H' '2' '2'; 'H' '3' '3';
        'C' '4' '5';
        'C' '4' '6';
        'C' '3' '4';
        'C' '3' '5';  'C' '3' '7';
        'C' '2' '4';  'C' '2' '6'; 'C' '2' '7';
        'C' '1' '5';  'C' '1' '6'; 'C' '1' '7'};
elseif algor_type_num == 2  % [[15,1,3]] encoding 의 경우
    operation_cell =  {'I' '1' '1';'I' '2' '2';'I' '3' '3';'I' '4' '4';'I' '5' '5';'I' '6' '6';'I' '7' '7';'I' '8' '8';'I' '9' '9';'I' '10' '10';'I' '11' '11';'I' '12' '12';'I' '13' '13';'I' '14' '14';'I' '15' '15';
        'H','1','1';'H','2','2';'H','4','4';'H','8','8';
        'C','8','9';'C','8','10';'C','8','11';'C','8','12';'C','8','13';'C','8','14';'C','8','15';
        'C','4','5';'C','4','6';'C','4','7';'C','4','12';'C','4','13';'C','4','14';'C','4','15';
        'C','2','3';'C','2','6';'C','2','7';'C','2','10';'C','2','11';'C','2','14';'C','2','15';
        'C','1','3';'C','1','5';'C','1','7';'C','1','9';'C','1','11';'C','1','13';'C','1','15';
        'C','15','3';'C','15','5';'C','15','6';'C','15','9';'C','15','10';'C','15','12'};
    
elseif algor_type_num == 3  % [[my algorithm]] encoding 의 경우
    operation_cell =  {'I' '1' '1';'I' '2' '2';'I' '3' '3';'I' '4' '4';'I' '5' '5';'I' '6' '6';'I' '7' '7';'I' '8' '8';'I' '9' '9';
        'C','1','2';'C','1','3';'C','1','4';'C','1','5';'C','1','6';'C','1','7';'C','1','8';'C','1','9';
        'C','2','1';'C','2','3';'C','2','4';'C','2','5';'C','2','6';'C','2','7';'C','2','8';'C','2','9';
        'C','3','1';'C','3','2';'C','3','4';'C','3','5';'C','3','6';'C','3','7';'C','3','8';'C','3','9';
        'C','4','1';'C','4','2';'C','4','3';'C','4','5';'C','4','6';'C','4','7';'C','4','8';'C','4','9';
        'C','5','1';'C','5','2';'C','5','3';'C','5','4';'C','5','6';'C','5','7';'C','5','8';'C','5','9';
        'C','6','1';'C','6','2';'C','6','3';'C','6','4';'C','6','5';'C','6','7';'C','6','8';'C','6','9';
        'C','7','1';'C','7','2';'C','7','3';'C','7','4';'C','7','5';'C','7','6';'C','7','8';'C','7','9';
        'C','8','1';'C','8','2';'C','8','3';'C','8','4';'C','8','5';'C','8','6';'C','8','7';'C','8','9';
        'C','9','1';'C','9','2';'C','9','3';'C','9','4';'C','9','5';'C','9','6';'C','9','7';'C','9','8';};
elseif algor_type_num == 4 % N = 15, a=7 shor code
    operation_cell_init = {'I' '1' '1' '1';'I' '2' '2' '2';'I' '3' '3' '3';'I' '4' '4' '4';'I' '5' '5' '5';'I' '6' '6' '6';
        'To' '1'  '4' '5'; 'To' '1'  '5' '4'; 'To' '1'  '4' '5';
        'To' '1'  '3' '4'; 'To' '1'  '4' '3'; 'To' '1'  '3' '4';
        'To' '1'  '3' '6'; 'To' '1'  '6' '3'; 'To' '1'  '3' '6';
        'To' '2'  '3' '5'; 'To' '2'  '5' '3'; 'To' '2'  '3' '5';
       'To' '2'  '4' '6'; 'To' '2'  '6' '4'; 'To' '2'  '4' '6';
        };
    operation_cell = Toffoli_decompostion(operation_cell_init);
elseif algor_type_num ==5 
    operation_cell_init = {'I' '1' '1' '-' '-' ; 'I' '2' '2' '-' '-' ;'I' '3' '3' '-' '-' ; 'I' '4' '4' '-' '-' ;'I' '5' '5' '-' '-' ;'I' '6' '6' '-' '-' ;'I' '7' '7' '-' '-' ;'I' '8' '8' '-' '-' ;'I' '9' '9' '-' '-' ;'I' '10' '10' '-' '-' ;'I' '11' '11' '-' '-' ;'I' '12' '12' '-' '-' ;'I' '13' '13' '-' '-' ;'I' '14' '14' '-' '-' ;'I' '15' '15' '-' '-' ;'I' '16' '16' '-' '-' ;
    'Carry_r' '1' '2' '3' '4';
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
init_operation2 = Carry_Sum(operation_cell_init);

operation_cell = Toffoli_decompostion(init_operation2);
elseif algor_type_num ==6
    operation_cell_init = {'I' '1' '1' '-' ;'I' '2' '2' '-' ;'I' '3' '3' '-' ;'I' '4' '4' '-' ;'I' '5' '5' '-' ;'I' '6' '6' '-' ;'I' '7' '7' '-' ;'I' '8' '8' '-' ;'I' '9' '9' '-' ;'I' '10' '10' '-' ;'I' '11' '11' '-' ;'I' '12' '12' '-' ;'I' '13' '13' '-' ;'I' '14' '14' '-' ;'I' '15' '15' '-' ;'I' '16' '16' '-' ;'I' '17' '17' '-' ;'I' '18' '18' '-' ;
    'MAJ' '1' '2' '3';
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
init_operation2 = MAJ_UMA(operation_cell_init);

operation_cell = Toffoli_decompostion(init_operation2);
elseif algor_type_num ==7
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

end

%% init placement 찾기
for loop_num = 1: loop_input_num
    fprintf("Loop 수 : %d \n",loop_num);
    if arch =='c-arch'
        if intial_placement_input_num==1
            if algor_type_num == 1
                init_placement = c_arch_placement_operation(3, operation_cell);
            elseif algor_type_num == 2 %
                init_placement =  c_arch_placement_operation(4, operation_cell);
                %% 내가 임의로 짠 알고리즘 인 경우
            elseif algor_type_num == 3
                init_placement = c_arch_placement_operation(3, operation_cell);
            elseif algor_type_num == 4
                init_placement = c_arch_placement_operation(3, operation_cell);
            elseif algor_type_num == 5
                init_placement = c_arch_placement_operation(4, operation_cell);
            elseif algor_type_num == 6
                init_placement = c_arch_placement_operation(5, operation_cell);
            elseif algor_type_num == 7
                init_placement = c_arch_placement_operation(5, operation_cell);
            end
        elseif intial_placement_input_num==2
            if algor_type_num == 1
                init_placement = c_arch_placement_operation(3, operation_cell);
            elseif algor_type_num == 2 
                init_placement =  init_recorded_all(arch, algor_type_num);
                %% 내가 임의로 짠 알고리즘 인 경우
            elseif algor_type_num == 3
                init_placement = c_arch_placement_operation(3, operation_cell);
            elseif algor_type_num == 4
                init_placement = c_arch_placement_operation(3, operation_cell);
            elseif algor_type_num == 5
                init_placement = init_recorded_all(arch, algor_type_num);
            elseif algor_type_num == 6
                init_placement = init_recorded_all(arch, algor_type_num);
            elseif algor_type_num == 7
                %% record를 받아서 기록하고 수정필요
                init_placement = init_recorded_all(arch, algor_type_num);
            end
        end
    elseif arch =='t-arch'
        if intial_placement_input_num ==1
            if algor_type_num == 1
                init_placement = t_arch_placement_operation(3, operation_cell);
            elseif algor_type_num == 2 %% [[15,1,3]]에 대해서는 미리 받을 수 있도록 작성해야함.
                init_placement = t_arch_placement_operation(4, operation_cell);
            elseif algor_type_num == 3
                init_placement = t_arch_placement_operation(3, operation_cell);
            elseif algor_type_num == 4
                init_placement = t_arch_placement_operation(3, operation_cell);
            elseif algor_type_num == 5
                init_placement = t_arch_placement_operation(4, operation_cell);
            elseif algor_type_num == 6
                init_placement = t_arch_placement_operation(5, operation_cell);
            elseif algor_type_num == 7
                init_placement = t_arch_placement_operation(5, operation_cell);
            end
        elseif intial_placement_input_num==2
            if algor_type_num == 1
                init_placement = t_arch_placement_operation(3, operation_cell);
            elseif algor_type_num == 2 %% [[15,1,3]]에 대해서는 미리 받을 수 있도록 작성해야함.
                init_placement =  init_recorded_all(arch, algor_type_num);
            elseif algor_type_num == 3
                init_placement = t_arch_placement_operation(3, operation_cell);
            elseif algor_type_num == 4
                init_placement = t_arch_placement_operation(3, operation_cell);
            elseif algor_type_num == 5
                init_placement = init_recorded_all(arch, algor_type_num);
            elseif algor_type_num == 6
                init_placement = init_recorded_all(arch, algor_type_num);
            elseif algor_type_num == 7
                init_placement = init_recorded_all(arch, algor_type_num);
            end
        end
        
    elseif arch =='prop_1'
        if intial_placement_input_num ==1
            if algor_type_num == 1
                init_placement =proposal1_placement_operation(7, operation_cell);
            elseif algor_type_num == 2 %% [[15,1,3]]에 대해서는 미리 받을 수 있도록 작성해야함.
                init_placement =  init_recorded_all(arch);
            elseif algor_type_num == 3
                init_placement =  proposal1_placement_operation(3, operation_cell);
            elseif algor_type_num == 4
                init_placement =  proposal1_placement_operation(6, operation_cell);
            elseif algor_type_num == 5
                init_placement =  init_recorded_all(arch, algor_type_num);
            elseif algor_type_num == 6
                init_placement =  init_recorded_all(arch, algor_type_num);
            elseif algor_type_num == 7
                init_placement =  proposal1_placement_operation(21, operation_cell);
            end
        elseif intial_placement_input_num==2
            if algor_type_num == 1
                init_placement =proposal1_placement_operation_sorting(7, operation_cell);
            elseif algor_type_num == 2 %% [[15,1,3]]에 대해서는 미리 받을 수 있도록 작성해야함.
                init_placement =  proposal1_placement_operation_sorting(15, operation_cell);
            elseif algor_type_num == 3
                init_placement = proposal1_placement_operation_sorting(9, operation_cell);
            elseif algor_type_num == 4
                init_placement =  proposal1_placement_operation_sorting(6, operation_cell);
            elseif algor_type_num == 5
                init_placement =  proposal1_placement_operation_sorting(16, operation_cell);
            elseif algor_type_num == 6
                init_placement =  proposal1_placement_operation_sorting(18, operation_cell);
            elseif algor_type_num == 7
                init_placement =  proposal1_placement_operation_sorting(21, operation_cell);       
            end
        end
    end
    
    %% Scheduling 하기
    fprintf("Scheduling 중\n")
    if arch_num == 1 || arch_num == 2
        Scheduled_operation = time_aligning(Scheduling_operation(operation_cell, arch));
        for i = 1 :length(Scheduled_operation)
            init_operation(i,:) = cellstr(strsplit(Scheduled_operation(i,1), ' '));
        end
    elseif arch_num==3
        init_operation = time_aligning(Scheduling_operation(operation_cell, arch));
    end
    class(Scheduled_operation)
    Scheduled_operation
    
    
    class(init_operation)
    init_operation
    
    %% Routing 및 파일에 쓰는 과정
    fprintf("Routing 중\n")
    %% routing 과정
    if arch_num == 1 || arch_num == 2 %c-arch or t-arch 의 경우
        [Routed_operation, Endtime] = Routing_operation_Sliding_Window(init_operation, arch , init_placement, window_size);
        
    elseif arch_num == 3 % prop1의 경우
        [Routed_operation, Endtime] = Routing_operation_prop1_window(init_operation, arch, init_placement, window_size);
    end
    %% 파일에 쓰는 과정
    if algor_type_num == 1
        if arch_num == 1
            fileID = fopen('[[7,1,3]]_t_arch.txt','a');
            fileID2 = fopen('[[7,1,3]]_t_arch_Endtime.txt','a');
        elseif arch_num ==2
            fileID = fopen('[[7,1,3]]_c_arch.txt','a');
            fileID2 = fopen('[[7,1,3]]_c_arch_Endtime.txt','a');
        elseif arch_num==3
            fileID = fopen('[[7,1,3]]_prop_1.txt','a');
            fileID2 = fopen('[[7,1,3]]_prop_1_Endtime.txt','a');
        end
    elseif algor_type_num == 2
        if arch_num == 1
            fileID = fopen('[[15,1,3]]_t_arch.txt','a');
            fileID2 = fopen('[[15,1,3]]_t_arch_Endtime.txt','a');
        elseif arch_num ==2
            fileID = fopen('[[15,1,3]]_c_arch.txt','a');
            fileID2 = fopen('[[15,1,3]]_c_arch_Endtime.txt','a');
        elseif arch_num==3
            fileID = fopen('[[15,1,3]]_prop_1.txt','a');
            fileID2 = fopen('[[15,1,3]]_prop_1_Endtime.txt','a');
        end
    elseif algor_type_num == 4
        if arch_num == 1
            fileID = fopen('N_15_a_7_t_arch.txt','a');
            fileID2 = fopen('N_15_a_7_t_arch_Endtime.txt','a');
        elseif arch_num ==2
            fileID = fopen('N_15_a_7_c_arch.txt','a');
            fileID2 = fopen('N_15_a_7_c_arch_Endtime.txt','a');
        elseif arch_num==3
            fileID = fopen('N_15_a_7_prop_1.txt','a');
            fileID2 = fopen('N_15_a_7_prop_1_Endtime.txt','a');
        end
    elseif algor_type_num == 5
        if arch_num == 1
            fileID = fopen('Adder0_t_arch.txt','a');
            fileID2 = fopen('Adder0_t_arch_Endtime.txt','a');
        elseif arch_num ==2
            fileID = fopen('Adder0_c_arch.txt','a');
            fileID2 = fopen('Adder0_c_arch_Endtime.txt','a');
        elseif arch_num==3
            fileID = fopen('Adder0_prop_1.txt','a');
            fileID2 = fopen('Adder0_prop_1_Endtime.txt','a');
        end
    elseif algor_type_num == 6
        if arch_num == 1
            fileID = fopen('Adder1_t_arch.txt','a');
            fileID2 = fopen('Adder1_t_arch_Endtime.txt','a');
        elseif arch_num ==2
            fileID = fopen('Adder1_c_arch.txt','a');
            fileID2 = fopen('Adder1_c_arch_Endtime.txt','a');
        elseif arch_num==3
            fileID = fopen('Adder1_prop_1.txt','a');
            fileID2 = fopen('Adder1_prop_1_Endtime.txt','a');
        end
     elseif algor_type_num == 7
        if arch_num == 1
            fileID = fopen('MULT4_t_arch.txt','a');
            fileID2 = fopen('MULT4_t_arch_Endtime.txt','a');
        elseif arch_num ==2
            fileID = fopen('MULT4_c_arch.txt','a');
            fileID2 = fopen('MULT41_c_arch_Endtime.txt','a');
        elseif arch_num==3
            fileID = fopen('MULT4_prop_1.txt','a');
            fileID2 = fopen('MULT4_prop_1_Endtime.txt','a');
        end
    end
    if loop_num ==1
        fprintf(fileID, 'Type 종류 : \t%s\t Init_placement 종류 : \t %s\t Window_size : \t %d\n',arch, place_type, window_size);
        fprintf(fileID2, 'Type 종류 : \t%s\t Init_placement 종류 : \t %s\t Window_size : \t %d\n',arch, place_type, window_size);
    end
    fprintf(fileID,'초기배치 : \n');
    placement_size = size(init_placement);
    for i = 1 : placement_size(1)
        for j=1 : placement_size(2)
            formatSpec2 = '%d\t';
            fprintf(fileID, formatSpec2, init_placement(i,j));
        end
        fprintf(fileID, '\n');
    end
    fprintf(fileID,'초기 Scheduled opeartion : \n');
    schduled_operation_size = size(init_operation);
    for i = 1: schduled_operation_size(1)
        formatSpec2 = '%s\n';
        %fprintf(f, formatSpec2, strjoin(a(i,:)));
        fprintf(fileID, formatSpec2, strjoin(init_operation(i,:)));
    end
    fprintf(fileID,'최종 Routed opeartion : \n');
    for  i = 1: length(Routed_operation(:,1))
        formatSpec2 = '%s\t %s\t %s\n';
        fprintf(fileID, formatSpec2, Routed_operation(i,1), Routed_operation(i,2), Routed_operation(i,3));
    end
    
    fprintf(fileID, 'loop : \t%d\tEndtime : \t%d\n',loop_num, Endtime);
    fprintf(fileID, '\n\n\n');
    fclose(fileID);
    fprintf(fileID2, 'loop : \t%d\tEndtime : \t%d\n',loop_num, Endtime);
    fclose(fileID2);
end






