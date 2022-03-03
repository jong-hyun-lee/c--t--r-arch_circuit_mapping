function all_final_placement = t_arch_placement_operation(layout_size, operation_cell)
%% 여기서 부터 자동으로 동작부분 %constellation 이 잘못됨. (21.12.25)
% qubit 위치 (m by m matrix 할당)
m = layout_size^2;
constellation = zeros(layout_size,layout_size);
for i = 1: layout_size
    x_rows(1,i) = i;
end
for i = 1: layout_size
    y_col(1,i) = i;
end
for i = 1:layout_size
    for j = 1:layout_size
        constellation(x_rows(i),y_col(j)) = x_rows(1,i)+(y_col(1,j)-1)*(layout_size);
    end
end
% 강제로 할당
% constelllation 위치에 따른 manhattan distance 파악 d = zeros(m,m);
for i =  1:m
    [row1,col1]=find(constellation== i);
    for j = 1:m
        [row2,col2]=find(constellation== j);
        d(i,j)  =  abs(row1-row2)+ abs(col1-col2);
    end
end
%
% 큐비트간의 operation(r_i,j 할당, 확인완료) %%해당 부분을 수정해야 함.
%%새로 짠 코드
operation_qubit1 = str2double(operation_cell(:,2));
operation_qubit2 = str2double(operation_cell(:,3));
r= zeros(m,m);
for i = 1 : length(operation_qubit1)
    r(operation_qubit1(i), operation_qubit2(i)) = r(operation_qubit1(i), operation_qubit2(i))+1;
    if operation_qubit1(i)~=operation_qubit2(i)
        r(operation_qubit2(i), operation_qubit1(i)) = r(operation_qubit2(i), operation_qubit1(i))+1;
    end
end
%for case_number  = 1:6
case_number = randi(6);
    %     % optimization
    w1 = optimvar('w1',m,m,'LowerBound',0);
    x = optimvar('x',m,m,'LowerBound',0,'UpperBound',1,'Type','integer');
    prob = optimproblem('Objective', sum(sum(w1)));
    cons1 = sum(x) == ones(1,m);
    cons2 = sum(transpose(x)) == ones(1,m);
    cons3 = max((transpose(sum(d))*sum(r)),0).*x + d*x*transpose(r)-w1<=max((transpose(sum(d))*sum(r)),0);
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
    problem = prob2struct(prob);
    %problem.options = optimoptions(@intlinprog,'OutputFcn',{@savemilpsolutions,@customFcn})
    
    [sol,fval,exitflag,output] = intlinprog(problem);
    
    %[r1_xIntSol,c1_xIntSol] = size(xIntSol);
    %for j = 1:c1_xIntSol
    x_layout_col = sol(m*m+1:end);
    for i=1:m
        x_layout(:,i) = x_layout_col((i-1)*m+1:i*m);
    end
    
    my_layout = x_layout;
    size_final_placement = size(constellation);
    final_placement(1:size_final_placement(1),1:size_final_placement(1)) = -1;
    for i =1 : m
        [r1, c1] = find(my_layout(:,i) >0.999);
        [r2, c2] = find(constellation==r1);
        final_placement(r2,c2) = i;
    end
    
    all_final_placement = final_placement(:,:);
    value_my(j) = trace(transpose(my_layout)*d*my_layout*r);
    value_my_w(j) = sum(sum(my_layout.*transpose(d*my_layout*transpose(r))));
%end

end

% %% 해당 부분은 ref의 검증을 위해서임.
%    ref_layout = [0,0,0,0,0,0,0,0,0,1,0,0,0;
%         0,0,0,0,0,0,0,0,1,0,0,0,0;
%         0,0,0,0,0,0,0,0,0,0,0,1,0;
%         0,0,0,0,0,0,0,1,0,0,0,0,0;
%         0,1,0,0,0,0,0,0,0,0,0,0,0;
%         0,0,1,0,0,0,0,0,0,0,0,0,0;
%         0,0,0,0,0,0,0,0,0,0,1,0,0;
%         0,0,0,0,1,0,0,0,0,0,0,0,0;
%         0,0,0,0,0,0,0,0,0,0,0,0,1;
%         0,0,0,0,0,1,0,0,0,0,0,0,0;
%         0,0,0,0,0,0,1,0,0,0,0,0,0;
%         1,0,0,0,0,0,0,0,0,0,0,0,0;
%         0,0,0,1,0,0,0,0,0,0,0,0,0 ];
%       % rotated 형태로 봤을 경우
%        ref_layout = [
%        0 0 0 0 0 0 0 1 0
%        0 0 0 0 0 1 0 0 0
%        1 0 0 0 0 0 0 0 0
%        0 0 0 0 0 0 0 0 1
%        0 1 0 0 0 0 0 0 0
%        0 0 0 0 1 0 0 0 0
%        0 0 0 0 0 0 1 0 0
%        0 0 0 1 0 0 0 0 0
%        0 0 1 0 0 0 0 0 0
%        ];
%
%
%
% for i =1 : m
%      [r1, c1] = find(ref_layout(:,i) > 0.999);
%      [r2, c2] = find(constellation==r1);
%      ref_placement(r2,c2) = i;
%  end



%value_ref= trace(transpose(ref_layout)*d*ref_layout*r);
%value_ref_w =sum(sum(ref_layout.*transpose(d*ref_layout*transpose(r))));