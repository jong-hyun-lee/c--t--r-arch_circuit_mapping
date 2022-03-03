function result = Toffoli_decompostion(init_operation)
[r1,~] = size(init_operation);
result  = '';
for i= 1: r1
    if string(init_operation(i,1)) ~="To"
        result = [result; init_operation(i,1:3)];
    else
        Toffoli_docomposition = ['H', init_operation(i,4), init_operation(i,4);
            'C', init_operation(i,3), init_operation(i,4);
            't', init_operation(i,4), init_operation(i,4);
            'C', init_operation(i,2), init_operation(i,4);
            
            'T', init_operation(i,4), init_operation(i,4);
            'C', init_operation(i,3), init_operation(i,4);
            't', init_operation(i,4), init_operation(i,4);
            'C', init_operation(i,2), init_operation(i,4);
            'T', init_operation(i,3), init_operation(i,3);
            'T', init_operation(i,4), init_operation(i,4);
            'C', init_operation(i,2), init_operation(i,3);
            'H', init_operation(i,4), init_operation(i,4);
            'T', init_operation(i,2), init_operation(i,2);
            't', init_operation(i,3), init_operation(i,3);
            'C', init_operation(i,2), init_operation(i,3)
            ];
        result = [result;Toffoli_docomposition];
    end
end

end