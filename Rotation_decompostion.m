function result = Rotation_decompostion(init_operation)
[r1,r2] = size(init_operation);
result  = '';
for i= 1: r1
    if string(init_operation(i,1)) ~="Rot1" && string(init_operation(i,1)) ~="Rot3"
        result = [result; init_operation(i,:)];
    elseif string(init_operation(i,1)) =="Rot1"
        Rot1_decompositon = [
            'C', init_operation(i,2), init_operation(i,3);
            'C', init_operation(i,3), init_operation(i,2);
            'C', init_operation(i,2), init_operation(i,3);
            
            'C', init_operation(i,3), init_operation(i,4);
            'C', init_operation(i,4), init_operation(i,3);
            'C', init_operation(i,3), init_operation(i,4);
            
            'C', init_operation(i,4), init_operation(i,5);
            'C', init_operation(i,5), init_operation(i,4);
            'C', init_operation(i,4), init_operation(i,5);
            
            'C', init_operation(i,5), init_operation(i,6);
            'C', init_operation(i,6), init_operation(i,5);
            'C', init_operation(i,5), init_operation(i,6);
            
            'C', init_operation(i,6), init_operation(i,7);
            'C', init_operation(i,7), init_operation(i,6);
            'C', init_operation(i,6), init_operation(i,7);
            
            'C', init_operation(i,7), init_operation(i,8);
            'C', init_operation(i,8), init_operation(i,7);
            'C', init_operation(i,7), init_operation(i,8);
            
            'C', init_operation(i,8), init_operation(i,9);
            'C', init_operation(i,9), init_operation(i,8);
            'C', init_operation(i,8), init_operation(i,9);];
       Rot1_decompositon(:,4:r2) = {'-'};
       %result = Rot1_decompositon
        result = [result;Rot1_decompositon];
    elseif string(init_operation(i,1)) =="Rot3"
        Rot3_decompositon = [
            'C', init_operation(i,8), init_operation(i,9);
            'C', init_operation(i,9), init_operation(i,8);
            'C', init_operation(i,8), init_operation(i,9);
            
            'C', init_operation(i,7), init_operation(i,8);
            'C', init_operation(i,8), init_operation(i,7);
            'C', init_operation(i,7), init_operation(i,8);
            
            'C', init_operation(i,6), init_operation(i,9);
            'C', init_operation(i,9), init_operation(i,6);
            'C', init_operation(i,6), init_operation(i,9);
            
            'C', init_operation(i,5), init_operation(i,8);
            'C', init_operation(i,8), init_operation(i,5);
            'C', init_operation(i,5), init_operation(i,8);
            
            'C', init_operation(i,4), init_operation(i,7);
            'C', init_operation(i,7), init_operation(i,4);
            'C', init_operation(i,4), init_operation(i,7);
            
            'C', init_operation(i,3), init_operation(i,6);
            'C', init_operation(i,6), init_operation(i,3);
            'C', init_operation(i,3), init_operation(i,6);
            
            'C', init_operation(i,2), init_operation(i,5);
            'C', init_operation(i,5), init_operation(i,2);
            'C', init_operation(i,2), init_operation(i,5);];
       Rot3_decompositon(:,4:r2) = {'-'};
       result = [result;Rot3_decompositon];
    end
end

end