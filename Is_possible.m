
function output = Is_possible(input_operation, compared_operation, placement, ~)
% input 및 전체 operation의 값을 원하는 형태로 불러옴
% operation_type_double 는 'C' 의 double 값 등을 불러옴
% operation_qubit1,2 은 input_operation 의 동작 큐비트 값을 불러옴
% starting_time_input_operation, end_time_input_operation 은 input 오퍼레이션의
% 주어진 시작 및 끝나는 시간을 불러옴

operation_name = char(input_operation(1)); % char 형태('C 1 2' 등이 저장)
input_scan = sscanf(operation_name, '%c %d %d'); % double
operation_type_double = input_scan(1); %double 형태 'C'의 ascii
operation_qubit1= input_scan(2);
operation_qubit2= input_scan(3);
starting_time_input_operation = str2double(input_operation(1,2));
end_time_input_operation = str2double(input_operation(1,3));

operation_name2 = char(compared_operation(1)); % char 형태('C 1 2' 등이 저장)
input_scan2 = sscanf(operation_name2, '%c %d %d'); % double
operation2_type_double = input_scan2(1); %double 형태 C의 ascii
operation2_qubit1= input_scan2(2);
operation2_qubit2= input_scan2(3);
starting_time_input_operation2 = str2double(compared_operation(1,2));
end_time_input_operation2 = str2double(compared_operation(1,3));

if (end_time_input_operation <= starting_time_input_operation2) || (starting_time_input_operation >=end_time_input_operation2)
    % 해당 경우의 operation_name_total(j,:) 은 input operation과 수행시간 무관
    % %%이부분까지 작성함
    % fprintf('case0');
    output = 'Y';
else
    [~, c1_input_operation] = find(placement==operation_qubit1);
    [~, c2_input_operation] = find(placement==operation_qubit2);
    [~, c1_operation2] = find(placement==operation2_qubit1);
    [~, c2_operation2] = find(placement==operation2_qubit2);
    if operation_type_double ==double('I') || operation_type_double ==double('H') || operation_type_double ==double('P') ||operation_type_double ==double('T') ||operation_type_double ==double('p') ||operation_type_double ==double('t')
        Is_single_qubit_operation = 'Y';
    elseif operation_type_double ==double('C') || operation_type_double ==double('S')
        Is_single_qubit_operation = 'N';
    end
    if operation2_type_double ==double('I') || operation2_type_double ==double('H') || operation2_type_double ==double('P') || operation2_type_double ==double('T')|| operation2_type_double ==double('p') || operation2_type_double ==double('t')
        Is_single_qubit_operation2 = 'Y';
    elseif operation2_type_double ==double('C') || operation2_type_double ==double('S')
        Is_single_qubit_operation2 = 'N';
    end
    if Is_single_qubit_operation == 'Y' &&  Is_single_qubit_operation2 =='Y'
        if c1_input_operation == c1_operation2
            output = 'N';
        else
            output = 'Y';
        end
    elseif (Is_single_qubit_operation == 'Y' &&  Is_single_qubit_operation2 =='N') || (Is_single_qubit_operation == 'N' &&  Is_single_qubit_operation2 =='Y') 
        if c1_input_operation == c1_operation2 || c1_input_operation == c2_operation2 ||  c2_input_operation == c1_operation2 || c2_input_operation == c2_operation2
            output = 'N';
        else
            output = 'Y';
        end
    elseif Is_single_qubit_operation == 'N' &&  Is_single_qubit_operation2 =='N'
        if min(c1_input_operation,c2_input_operation)>max(c1_operation2,c2_operation2)
            output = 'Y';
        elseif max(c1_input_operation,c2_input_operation)<min(c1_operation2,c2_operation2)
            output = 'Y';
        else
            output = 'N';
        end
        
    end
        
    
end
end