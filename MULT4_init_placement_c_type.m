clc
clear
%% MULT4 의 c-type 에서 초기배치 찾기
layout_size = 5;
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

for case_number = 1:6
    if case_number ==1 ||case_number == 3
        init_placement =c_arch_placement_operation_case(layout_size, operation_cell, case_number);
        fileID= fopen('MULT4_c_arch_초기배치.txt','a');
        
        fprintf(fileID,'case_number : %d \t 초기배치 : \n', case_number);
        placement_size = size(init_placement);
        for i = 1 : placement_size(1)
            for j=1 : placement_size(2)
                formatSpec2 = '%d\t';
                fprintf(fileID, formatSpec2, init_placement(i,j));
            end
            fprintf(fileID, '\n');
        end
        fclose(fileID);
    end
end