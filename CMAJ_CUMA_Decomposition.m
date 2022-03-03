function result = CMAJ_CUMA_Decomposition(init_operation)
[r1,r2] = size(init_operation);
%r2 = 19
result  = '';
for i= 1: r1
    if string(init_operation(i,1)) ~="CMAJ" && string(init_operation(i,1)) ~="CUMA"
        result = [result; init_operation(i,:)];
    elseif string(init_operation(i,1)) =="CMAJ"
        CMAJ_decompositon = ['To', init_operation(i,2), init_operation(i,5), init_operation(i,4);
            'C', init_operation(i,5), init_operation(i,3), '-';
            'To', init_operation(i,3), init_operation(i,4), init_operation(i,5)
            ];
        CMAJ_decompositon(:, 5:r2) = {'-'};
        result = [result;CMAJ_decompositon];
    elseif string(init_operation(i,1)) =="CUMA"
        CUMA_decompositon = [
            'To', init_operation(i,3), init_operation(i,4), init_operation(i,5);
            'C', init_operation(i,5), init_operation(i,3), '-';
            'To', init_operation(i,2), init_operation(i,3), init_operation(i,4);
            ];
        CUMA_decompositon(:, 5:r2) = {'-'};
        result = [result;CUMA_decompositon];
    end
end

end
