function result = Scheduling_operation_edge_type1_final(R_operation, arch)
[cycles_Init,cycles_H,cycles_CNOT,cycles_SWAP,cycles_P, cycles_T] = all_operaiton_time(arch);

[r_R,~] = size(R_operation);
Routed_operation = "";

for i = 1:r_R

    Routed_operation(i,1) = string(join(R_operation(i,:)));
    if string(R_operation(i,1)) == 'I'
            duration = cycles_Init;
        elseif string(R_operation(i,1)) == 'H'
            duration = cycles_H;
        elseif string(R_operation(i,1)) == 'S'
            duration = cycles_SWAP;
        elseif string(R_operation(i,1)) == 'C'
            duration = cycles_CNOT;
        elseif string(R_operation(i,1)) == 'T' ||  string(R_operation(i,1)) == 't'
            duration = cycles_T;
        elseif string(R_operation(i,1)) == 'P'|| string(R_operation(i,1)) == 'p'
            duration = cycles_P;
    end
    if i ==1
        Routed_operation(i,2) = string(0);
        Routed_operation(i,3) = string(duration);
    elseif i~=1
        
        %R_operation
        %Routed_operation
        qubit_component1 = find(string(R_operation(1:i-1,2))==string(R_operation(i,2)));
        qubit_component2 = find(string(R_operation(1:i-1,2))==string(R_operation(i,3)));
        qubit_component3 = find(string(R_operation(1:i-1,3))==string(R_operation(i,2)));
        qubit_component4 = find(string(R_operation(1:i-1,3))==string(R_operation(i,3)));
%         if i == 19
%             qubit_component1
%             qubit_component2
%             qubit_component3
%             qubit_component4
%         end
        if isempty(qubit_component1) && isempty(qubit_component2) && isempty(qubit_component3) && isempty(qubit_component4)
            Routed_operation(i,2) = string(0);
            Routed_operation(i,3) = string(duration);
        else
            max_comp1 = Routed_operation(max(qubit_component1),3);
            max_comp2 = Routed_operation(max(qubit_component2),3);
            max_comp3 = Routed_operation(max(qubit_component3),3);
            max_comp4 = Routed_operation(max(qubit_component4),3);
            
            if isempty(max_comp1)
                max_comp1= 0;
            end 
            if isempty(max_comp2)
                max_comp2= 0;
            end 
            if isempty(max_comp3)
                max_comp3= 0;
            end 
            if isempty(max_comp4)
                max_comp4= 0;
            end 
            
            max_comp_all = max(max(double(string(max_comp1)), double(string(max_comp2))), max(double(string(max_comp3)), double(string(max_comp4))));
            Routed_operation(i,2) = {max_comp_all};
            Routed_operation(i,3) = {double(max_comp_all)+duration};
        end
    end
    
    
end
result = Routed_operation;
%endtime = max(double(Routed_operation(:,3)));
end