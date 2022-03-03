function result = MAJ_UMA(init_operation)
% input 은 'MAJ' '1' '2' '3' 와 같이 num_operation x 4  행렬
% output 은 Toffoli 등을 포함한 'To' '1' '2' '3' 의 col x 4 행렬
[r1,~] = size(init_operation);
result  = '';
for i= 1: r1
    if string(init_operation(i,1)) ~="MAJ" && string(init_operation(i,1)) ~="UMA"
        result = [result; init_operation(i,1:4)];
    elseif string(init_operation(i,1)) =="MAJ"
        MAJ_docomposition = ['C', init_operation(i,4), init_operation(i,3), '-';
            'C', init_operation(i,4), init_operation(i,2), '-';
            'To', init_operation(i,2), init_operation(i,3), init_operation(i,4);
            ];
        result = [result;MAJ_docomposition];
    elseif string(init_operation(i,1)) =="UMA"
        UMA_docomposition = ['To', init_operation(i,2), init_operation(i,3), init_operation(i,4);
            'C', init_operation(i,4), init_operation(i,2), '-';
            'C', init_operation(i,2), init_operation(i,3), '-';
            ];
        result = [result;UMA_docomposition];  
    end
end