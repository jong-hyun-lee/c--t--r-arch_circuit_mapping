function result = Carry_Sum(init_operation)
% input 은 'Carry' '1' '2' '3' '4' 와 같이 num_operation x 5  행렬
% output 은 Toffoli 등을 포함한 'To' '1' '2' '3' 의 col x 4 행렬


[r1,~] = size(init_operation);
result  = '';
for i= 1: r1
    if string(init_operation(i,1)) ~="Carry_r" && string(init_operation(i,1)) ~="Carry_l" &&string(init_operation(i,1)) ~="Sum"
        result = [result; init_operation(i,1:4)];
    elseif string(init_operation(i,1)) =="Carry_l"
        Carry_l_docomposition = ['To', init_operation(i,5), init_operation(i,3), init_operation(i,2);
            'C', init_operation(i,4), init_operation(i,3), '-';
            'To', init_operation(i,4), init_operation(i,3), init_operation(i,2);
            ];
        result = [result;Carry_l_docomposition];
    elseif string(init_operation(i,1)) =="Carry_r"
        Carry_r_docomposition = ['To', init_operation(i,3), init_operation(i,4), init_operation(i,5);
            'C', init_operation(i,3), init_operation(i,4), '-';
            'To', init_operation(i,2), init_operation(i,4), init_operation(i,5);
            ];
        result = [result;Carry_r_docomposition];
        
        
    elseif string(init_operation(i,1)) =="Sum"
        Sum_docomposition = ['C', init_operation(i,3), init_operation(i,4), '-';
            'C', init_operation(i,2), init_operation(i,4), '-';
            ];
        result = [result;Sum_docomposition];
    end
    
end
end