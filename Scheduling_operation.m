function Result = Scheduling_operation(operation_cell, arch)
[cycles_Init,cycles_H,cycles_CNOT,cycles_SWAP,cycles_P, cycles_T] = all_operaiton_time(arch);
operation(:,1) = char(operation_cell(:,1)); %operation 은 operation type을 받음
operation_qubit(:,2:3)=str2double(operation_cell(:,2:3)); %동작 operation qubit를 받음
operation_size = size(operation);

starting = [];
target = [];
edge_type = [];
operation_time = [];
G_original = digraph(starting,target);
%operation_size(1)
for i = 1: operation_size(1)
    if operation(i,1) =='I'
        operation_time = [operation_time cycles_Init];
    elseif operation(i,1) =='H'
        operation_time = [operation_time cycles_H];
    elseif operation(i,1) =='C'
        operation_time = [operation_time cycles_CNOT];
    elseif operation(i,1) =='S'
        operation_time = [operation_time cycles_SWAP];
    elseif operation(i,1) =='P'||operation(i,1) =='p'
        operation_time = [operation_time cycles_P];
    elseif operation(i,1) =='T'||operation(i,1) =='t'
        operation_time = [operation_time cycles_T];
        
    end
    operation_name(i,1) = join(operation_cell(i,:));
    
end

for i=1: operation_size(1)  %%Graph 를 생성하는 부분 %%기본적으로 먼저 operation_cell에 기입된 operation이 먼저 수행되어야 한다고 생각하는 operation 임
    %G=addnode(G,1) %%해당부분 추가? 21.12.06
    %G=addnode(G,1)
    for j=i+1:operation_size(1)
        %I -> H, CNOT, SWAP, P, T 은 commute 할 수 없음
        if operation(i,1) == 'I'
            if operation_qubit(i,2) == operation_qubit(j,2) || operation_qubit(i,3) == operation_qubit(j,3)
                starting= [starting i];
                target= [target j];
                edge_type = [edge_type 1];
            end
        
        
        elseif operation(i,1) =='H'||operation(i,1) =='P'||operation(i,1) =='T'||operation(i,1) =='p'||operation(i,1) =='t'
            if operation(j,1) == 'I'
                if operation_qubit(i,2) == operation_qubit(j,2) || operation_qubit(i,3) == operation_qubit(j,3)
                    fprintf("Initialize before Hadamard operation")
                end
            end
            % H -> H, CNOT, P, T 은 commute 할 수 없음
            if operation(j,1) == 'H' || operation(j,1) == 'C' || operation(j,1) == 'P' || operation(j,1) == 'T'|| operation(j,1) == 'p' || operation(j,1) == 't'
                if operation_qubit(i,2) == operation_qubit(j,2) || operation_qubit(i,3) == operation_qubit(j,3)
                    starting= [starting i];
                    target= [target j];
                    edge_type = [edge_type 1];
                end
            end
            % H -> SWAP은 commute 가능 함
            if operation(j,1) == 'H' || operation(j,1) == 'S'
                if operation_qubit(i,2) == operation_qubit(j,2) || operation_qubit(i,3) == operation_qubit(j,3)
                    starting= [starting i];
                    target= [target j];
                    edge_type = [edge_type 2];
                end
            end
        
        elseif operation(i,1) =='C'
            
            if operation(j,1) =='I'
                if operation_qubit(i,2) == operation_qubit(j,2) || operation_qubit(i,3) == operation_qubit(j,3)
                    fprintf("Initialize before CNOT operation")
                end
                % CNOT->H, P, T는 commute 할 수 없음
            elseif operation(j,1) =='H' || operation(j,1) == 'P' || operation(j,1) == 'T'|| operation(j,1) == 'p' || operation(j,1) == 't'
                if operation_qubit(i,2) == operation_qubit(j,2) || operation_qubit(i,3) == operation_qubit(j,3)
                    starting= [starting i];
                    target= [target j];
                    edge_type = [edge_type 1];
                end
                %CNOT->CNOT은 종류에 따라 commute, commute 불가가 나뉨
                %CNOT->CNOT 에서 같은 control 이 target이 되거나, target이
                %control이 되면 commute 할 수 없음
            elseif operation(j,1) =='C'
                if operation_qubit(i,2) == operation_qubit(j,3) || operation_qubit(i,3) == operation_qubit(j,2)
                    starting= [starting i];
                    target= [target j];
                    edge_type = [edge_type 1];
                    %CNOT->CNOT 이면 control 이 target이 되거나 target이
                    %control 이 되면 commute 할 수 있음
                elseif operation_qubit(i,2) == operation_qubit(j,2) || operation_qubit(i,3) == operation_qubit(j,3)
                    starting= [starting i];
                    target= [target j];
                    edge_type = [edge_type 2];
                end
                %CNOT->SWAP 은 NN을 해칠 수 있음으로 Commute 할 수 없음
            elseif operation(j,1) =='S'
                if operation_qubit(i,2) == operation_qubit(j,2) || operation_qubit(i,3) == operation_qubit(j,3) || operation_qubit(i,2) == operation_qubit(j,3) || operation_qubit(i,3) == operation_qubit(j,2)
                    starting= [starting i];
                    target= [target j];
                    edge_type = [edge_type 1];
                end
            end
        
        elseif operation(i,1) =='S'
            if operation(j,1) =='I'
                if operation_qubit(i,2) == operation_qubit(j,2) || operation_qubit(i,3) == operation_qubit(j,3)
                    fprintf("Initialize before CNOT operation")
                end
                
                %SWAP->H 는 commute 가능
            elseif operation(j,1) =='H'|| operation(j,1) == 'P' || operation(j,1) == 'T'|| operation(j,1) == 'p' || operation(j,1) == 't'
                if operation_qubit(i,2) == operation_qubit(j,2) || operation_qubit(i,3) == operation_qubit(j,3)
                    starting= [starting i];
                    target= [target j];
                    edge_type = [edge_type 2];
                end
                %SWAP->CNOT 는 commute 불가능(NN을 해칠 수 있음으로)
            elseif operation(j,1) =='C'
                if operation_qubit(i,2) == operation_qubit(j,2) || operation_qubit(i,3) == operation_qubit(j,3) ||operation_qubit(i,2) == operation_qubit(j,3) || operation_qubit(i,3) == operation_qubit(j,2)
                    starting= [starting i];
                    target= [target j];
                    edge_type = [edge_type 1];
                end
                %SWAP->SWAP 는 commute 불가능(NN을 해칠 수 있음으로)
            elseif operation(j,1) =='S'
                if operation_qubit(i,2) == operation_qubit(j,2) || operation_qubit(i,3) == operation_qubit(j,3) ||operation_qubit(i,2) == operation_qubit(j,3) || operation_qubit(i,3) == operation_qubit(j,2)
                    starting= [starting i];
                    target= [target j];
                    edge_type = [edge_type 1];
                end
            end
        
        end
         
            
    end
end

if ~isempty(starting)
    G_original=addnode(G_original, operation_size(1));
    %같은 node name 이 생길 수 있음으로, 서로 다르게 표시해주는 과정
    for i= 1:operation_size(1)
        index = find(strcmp(operation_name, operation_name(i)));
        if find(index==i)
            numbering=cellstr(strcat('#', string(i)));
            node_name(i,1) = strcat(operation_name(i,1), numbering);
        end
    end
    
    G_original.Nodes.Name = node_name;
    G_original=addedge(G_original , starting,target,edge_type)%', 'VariableNames', {'Weight'})
    G_original.Nodes.Time = operation_time';
    G = digraph([],[]); %% G 는 permuted G를 생성
    random_vector = randperm(height(G_original.Edges));
    for i = 1 : height(G_original.Edges)
        G=addedge(G, G_original.Edges(random_vector(i),:));
    end
    if height(G.Nodes) ~= height(G_original.Nodes)
        for i =1:height(G_original.Nodes)
            %G.Nodes(i,1)
            if ismember(G_original.Nodes(i,1),G.Nodes(:,1)) == 0
                %G.Nodes(i,1)
                G=addnode(G, G_original.Nodes(i,1));
            end
        end
    end
    for i =1 :height(G.Nodes)
        temp(i,:) = sscanf(char(table2cell(G.Nodes(i,1))), '%c %d %d %c %d');
        if temp(i,1)== double('C')
            operation2_time(1,i) = cycles_CNOT;
        elseif temp(i,1)== double('I')
            operation2_time(1,i) = cycles_Init;
        elseif temp(i,1)== double('T') ||temp(i,1)== double('t')
            operation2_time(1,i) = cycles_T;
        elseif temp(i,1)== double('S')
            operation2_time(1,i) = cycles_SWAP;
        elseif temp(i,1)== double('P') || temp(i,1)== double('p')
            operation2_time(1,i) = cycles_P;
        elseif temp(i,1)== double('H')
            operation2_time(1,i) = cycles_H;
        end
    end
    G.Nodes.Time = operation2_time';
    G_original.Nodes.Time = operation_time';
    %plot(G, 'LineWidth',G.Edges.Weight);
    num_edge = height(G_original.Edges);
    num_edge1 = sum(G_original.Edges.Weight==1);
    num_edge2 = sum(G_original.Edges.Weight==2);
    
    %% 논문에서 제안된 optimization 방법
    
    %{a(0), b(0)},{a(1), b(1)} 에서 0인 constraint 가 동작하고 있는 것임 (or 중에서)
    final_time = optimvar('final_time',1,'LowerBound',1,'Type','integer');
    s_v = optimvar('s_v',height(G.Nodes),'LowerBound',0,'Type','integer');
    if num_edge2 ~= 0
        a = optimvar('a',num_edge,'LowerBound',0,'Type','integer');
        b = optimvar('b',num_edge,'LowerBound',0,'Type','integer');
        M = sum(G.Nodes.Time)+1;
    end
    prob = optimproblem('Objective', final_time);
    
    for j=1 : height(G.Edges)
        % edge 1에 속하는 node 들의 constraint
        if G.Edges.Weight(j)==1
            cons5(j) = s_v(find(strcmp(G.Nodes.Name, G.Edges.EndNodes(j,2))))-s_v(find(strcmp(G.Nodes.Name, G.Edges.EndNodes(j,1))))>=G.Nodes.Time(find(strcmp(G.Nodes.Name, G.Edges.EndNodes(j,1))));
        end
        for i =1:height(G.Nodes)
            cons4(i) = final_time >= s_v(i)+G.Nodes.Time(i);
        end
        % edge 2에 속하는 node 들의 constraint
        % a(j) = 0 이면 cons1 이 true, b(j)=0 이면 cons2 가 true
        if num_edge2 ~=0
            if G.Edges.Weight(j)==2
                cons1(j) = s_v(find(strcmp(G.Nodes.Name, G.Edges.EndNodes(j,1))))-s_v(find(strcmp(G.Nodes.Name, G.Edges.EndNodes(j,2))))>=G.Nodes.Time(find(strcmp(G.Nodes.Name, G.Edges.EndNodes(j,2))))-M*a(j);
                cons2(j) = s_v(find(strcmp(G.Nodes.Name, G.Edges.EndNodes(j,2))))-s_v(find(strcmp(G.Nodes.Name, G.Edges.EndNodes(j,1))))>=G.Nodes.Time(find(strcmp(G.Nodes.Name, G.Edges.EndNodes(j,1))))-M*b(j);
                cons3(j) = a(j)+b(j) <=1;
            end
        end
    end

    if num_edge2 ~= 0
        if randi(2) ==1
            prob.Constraints.cons1 = cons1;
            prob.Constraints.cons2 = cons2;
        else
            prob.Constraints.cons1 = cons2;
            prob.Constraints.cons2 = cons1;
        end
        prob.Constraints.cons3 = cons3;
    end
    prob.Constraints.cons4 = cons4;
    if num_edge1 ~=0
        prob.Constraints.cons5 = cons5;
    end

    problem = prob2struct(prob);
    %% 옵션 설정 중임. 아래 부분. max node 혹은 MaxTime를 설정해주어야 함( 적당한 num_int_sol =1이 되는 점을 찾아서)
    options = optimoptions('intlinprog', 'Display', 'off');
    problem.options = options;
      
    
    if num_edge2 ==0
        [sol,fval,exitflag,output] = intlinprog(problem);
    else
        [sol,fval,exitflag,output] = intlinprog(problem);
    end
    if num_edge2 ~=0
        sol_a = sol(1:num_edge);
        sol_b = sol(num_edge+1:2*num_edge);
        sol_final_time = sol(2*num_edge+1);
        time_starting = sol(2*num_edge+2:2*num_edge+1+height(G.Nodes));
        end_time = time_starting+G.Nodes.Time;
    else
        sol_final_time = sol(1);
        time_starting = sol(2:height(G.Nodes)+1);
        end_time = time_starting+G.Nodes.Time;
    end
    
    
    for i = 1: height(G.Nodes)
        temp2= sscanf(char(table2cell(G.Nodes(i,1))), '%c %d %d %d');
        new_operation(i,1) = convertCharsToStrings(char(temp2(1)));
        new_operation(i,2:3) =num2cell(temp2(2:3));
    end
    
    Result = [string(join(new_operation)) time_starting end_time];
    
    
    
else
    Result= [string(operation_name) zeros(length(operation_name),1) operation_time'];
    
end

Result = time_aligning(Result);
end
