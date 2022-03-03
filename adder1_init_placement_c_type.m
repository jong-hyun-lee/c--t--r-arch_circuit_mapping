clc
clear
%% adder1 의 c-type 에서 초기배치 찾기
layout_size = 5;
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
    'UMA' '1' '2' '3'};
init_operation2 = MAJ_UMA(init_operation);

operation_cell = Toffoli_decompostion(init_operation2);

for case_number = 1:6
init_placement =c_arch_placement_operation_case(layout_size, operation_cell, case_number);
fileID= fopen('adder1_c_arch_초기배치.txt','a');

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