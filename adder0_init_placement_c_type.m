clc
clear
%% adder 0 의 c-type 에서 초기배치 찾기
layout_size = 4;
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
    'Sum' '1' '2' '3' '-'};
init_operation2 = Carry_Sum(init_operation);
operation_cell = Toffoli_decompostion(init_operation2);

for case_number = 1:6
init_placement =c_arch_placement_operation_case(layout_size, operation_cell, case_number);
fileID= fopen('adder0_c_arch_초기배치.txt','a');

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