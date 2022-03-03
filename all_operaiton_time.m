%% architecutre 별 operation time
function [cycles_Init,cycles_H,cycles_CNOT,cycles_SWAP,cycles_P, cycles_T] = all_operaiton_time(arch)
%arch
if arch == 't-arch'
    cycles_SWAP = 3;
    cycles_Init = 1;
    cycles_H = 4;
    cycles_CNOT = 4;
    cycles_P = 2; 
    cycles_T = 4;
elseif arch == 'c-arch'
    cycles_SWAP = 9;
    cycles_Init = 1;
    cycles_H = 4;
    cycles_CNOT = 3;
    cycles_P = 2; 
    cycles_T = 4;
elseif arch =='prop_1'
    cycles_SWAP = 9;
    cycles_Init = 1;
    cycles_H = 4;
    cycles_CNOT = 4;
    cycles_P = 2; 
    cycles_T = 4;
end
end