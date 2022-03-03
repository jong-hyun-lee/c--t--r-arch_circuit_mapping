%% 자동으로 돌아가는 부분
% qubit 위치 (1 by m matrix 할당)
function all_final_placement = proposal1_placement_operation_case(layout_size, operation_cell, case_number)
n= layout_size;
m=n;
constellation = zeros(1,m);
for i = 1: m
    constellation(1,i) = i;
end

% constelllation 위치에 따른 manhattan distance 파악
d = zeros(m,m);
for i = 1 : m
    [row1,col1]=find(constellation== i);
    for j = 1:m
        [row2,col2]=find(constellation== j);
        d(i,j)  = abs(row1-row2)+ abs(col1-col2);
    end
end

operation_qubit1 = str2double(operation_cell(:,2));
operation_qubit2 = str2double(operation_cell(:,3));
r= zeros(m,m);
for i = 1 : length(operation_qubit1)
    r(operation_qubit1(i), operation_qubit2(i)) = r(operation_qubit1(i), operation_qubit2(i))+1;
    if operation_qubit1(i)~=operation_qubit2(i)
        r(operation_qubit2(i), operation_qubit1(i)) = r(operation_qubit2(i), operation_qubit1(i))+1;
    end
end

% optimization
%for case_number  = 1:6
%case_number = randi(6);
    w1 = optimvar('w1',m,m,'LowerBound',0);
    x = optimvar('x',m,m,'LowerBound',0,'UpperBound',1,'Type','integer');%
    prob = optimproblem('Objective', sum(sum(w1)));
    cons1 = sum(x) == ones(1,m);
    cons2 = sum(transpose(x)) == ones(1,m);
    cons3 = max((transpose(sum(d))*sum(r)), 0).*x + d*x*transpose(r)-w1<=max((transpose(sum(d))*sum(r)),0);
 
    if case_number == 1
        prob.Constraints.cons1= cons1;
        prob.Constraints.cons2= cons2;
        prob.Constraints.cons3= cons3;
    elseif case_number ==2
        prob.Constraints.cons1= cons1;
        prob.Constraints.cons2= cons3;
        prob.Constraints.cons3= cons2;
    elseif case_number ==3
        prob.Constraints.cons1= cons2;
        prob.Constraints.cons2= cons1;
        prob.Constraints.cons3= cons3;
    elseif case_number ==4
        prob.Constraints.cons1= cons2;
        prob.Constraints.cons2= cons3;
        prob.Constraints.cons3= cons1;
    elseif case_number ==5
        prob.Constraints.cons1= cons3;
        prob.Constraints.cons2= cons1;
        prob.Constraints.cons3= cons2;
    elseif case_number ==6
        prob.Constraints.cons1= cons3;
        prob.Constraints.cons2= cons2;
        prob.Constraints.cons3= cons1;
    end
    
    %prob.Constraints.cons4 = cons4;
    
    %% 임시값 random 한 값 넣기는 하는데 의미는 없는 듯..
    %A = eye(m,m);
    %random_vector = randperm(m)
    %idx = varindex(prob)
    %disp( num_edge)
    %A(random_vector,:);
    
    
    problem = prob2struct(prob);
    %fprintf("!!!\n")
    %disp(problem.x0)
    [sol,fval,exitflag,output] = intlinprog(problem);
    sol=round(sol);
    %
    x_layout_col = sol(m*m+1:end); %%확인완료
    for i=1:m %%확인완료
        x_layout(:,i) = x_layout_col((i-1)*m+1:i*m);
    end
    %
    my_layout = x_layout;
    
    for i =1 : m
 
        [r1, ~] = find(my_layout(:,i)~=0);
        [r2, c2] = find(constellation==r1);
        final_placement(r2,c2) = i;
    end
    
    all_final_placement = final_placement;
end

%value_my = trace(transpose(my_layout)*d*my_layout*r)
%value_my_w = sum(sum(my_layout.*transpose(d*my_layout*transpose(r))))
% ref = [
%     0 0 1 0 0 0 0 ;
%     0 0 0 0 1 0 0 ;
%     0 0 0 1 0 0 0 ;
%     0 0 0 0 0 1 0 ;
%     0 1 0 0 0 0 0 ;
%     0 0 0 0 0 0 1 ;
%     1 0 0 0 0 0 0 ];
%     for i =1 : m
%         [r1, c1] = find(ref(:,i) ~=0);
%         [r2, c2] = find(constellation==r1);
%         a(r2,c2) = i;
%     end
%
%     value_ref = trace(transpose(ref)*d*ref*r)
%value_ref_w = sum(sum(ref.*transpose(d*ref*transpose(r))))

%end
