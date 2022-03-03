function result = Controlled_adder(init_operation)
[r1,r2] = size(init_operation);
result  = '';
for i= 1: r1
    if string(init_operation(i,1)) ~="C_adder"
        result = [result; init_operation(i,:)];
    else
        C_adder_docomposition = [
            'CMAJ', init_operation(i,2), init_operation(i,3), init_operation(i,18), init_operation(i,19);
            'CMAJ', init_operation(i,2), init_operation(i,19), init_operation(i,16), init_operation(i,17);
            'CMAJ', init_operation(i,2), init_operation(i,17), init_operation(i,14), init_operation(i,15);
            'CMAJ', init_operation(i,2), init_operation(i,15), init_operation(i,12), init_operation(i,13);
            'CMAJ', init_operation(i,2), init_operation(i,13), init_operation(i,10), init_operation(i,11);
            'CMAJ', init_operation(i,2), init_operation(i,11), init_operation(i,8), init_operation(i,9);
            'CMAJ', init_operation(i,2), init_operation(i,9), init_operation(i,6), init_operation(i,7);

            'To'  , init_operation(i,2), init_operation(i,5), init_operation(i,4), '-';
            'To'  , init_operation(i,2), init_operation(i,7), init_operation(i,4), '-';
     
            'CUMA', init_operation(i,2), init_operation(i,9), init_operation(i,6), init_operation(i,7);
            'CUMA', init_operation(i,2), init_operation(i,11), init_operation(i,8), init_operation(i,9);
            'CUMA', init_operation(i,2), init_operation(i,13), init_operation(i,10), init_operation(i,11);
            'CUMA', init_operation(i,2), init_operation(i,15), init_operation(i,12), init_operation(i,13);
            'CUMA', init_operation(i,2), init_operation(i,17), init_operation(i,14), init_operation(i,15);
            'CUMA', init_operation(i,2), init_operation(i,19), init_operation(i,16), init_operation(i,17);
            'CUMA', init_operation(i,2), init_operation(i,3), init_operation(i,18), init_operation(i,19);
            ];
        C_adder_docomposition(:,6:r2) = {'-'};
        result = [result;C_adder_docomposition];
        
    end
end


end