function result = Scheduling_format_conversion(input)%Scheduling_format_conversion(a)
%I='I';
%H= 'H';C= 'C';T= 'T';t= 't';
result = [];
[r_input,c_input ] = size(input);
for i = 1:c_input/5
    a = input(:,5*(i-1)+1:5*i);
    
if string(a(1,1)) ~='I'
    size_a = size(a);
    b= string(a(:,2:end));
    b(:, 3:4) = string(double(b(:, 3:4))+1);
    c = string(a(:,1));
    test = [c, b];
    d= append(test(:,1),' ', test(:,2),' ', test(:,3));
    d= [d, b(:,3:4)];
    Qubit_use = max(max(double(b(:,1)),double(b(:,2))));
    initialization = [];
    
    for i = 1: Qubit_use
        initialization = ['I' string(i) string(i); initialization];
    end
    e = append(initialization(:,1),' ', initialization(:,2),' ', initialization(:,3));
    e(:,2) = 0;
    e(:,3) = 1;
    output = [e ; d];
else
    size_a = size(a);
    b= string(a(:,2:end));
    b(:, 3:4) = string(double(b(:, 3:4)));
    c = string(a(:,1));
    test = [c, b];
    d= append(test(:,1),' ', test(:,2),' ', test(:,3));
    d= [d, b(:,3:4)];
    Qubit_use = max(max(double(b(:,1)),double(b(:,2))));
    initialization = [];
    output =  d;
end
result = [result output];
end

schduled_operation_size = size(output);

end
%fprintf(fileID, '\n');
%fclose(fileID);





