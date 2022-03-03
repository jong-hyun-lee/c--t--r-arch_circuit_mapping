function [final_operation, endtime] = Routing_operation_proposal1(init_operation, arch, init_placement)
%%알고리즘 시작
%[cycles_SWAP,cycles_Init,cycles_H,cycles_CNOT] = all_operaiton_time(arch);
[r_init_operation, ~] = size(init_operation);
final_operation = init_operation;
for i = 1 : r_init_operation-1
    for j = i+1 : r_init_operation
        
        if Is_possible (final_operation(i,:), final_operation(j,:), init_placement, 'pro1')=='Y'
            
        elseif Is_possible (final_operation(i,:), final_operation(j,:), init_placement, 'pro1')=='N'
            remained_operation ={};
            %temp=[];
            input_scan = [];
            temp = final_operation(j:end,1);
            [r_temp,~] = size(temp);
            %temp 를 schduling 함수에 넣을 수 있는 cell 형으로 전환
            for k= 1:r_temp
                input_scan(k,:) = sscanf(char(temp(k,1)), '%c %d %d'); % double
            end
            remained_operation(:,1) = cellstr(char(input_scan(:,1)));
            remained_operation(:,2) = cellstr(num2str(input_scan(:,2)));
            remained_operation(:,3) = cellstr(num2str(input_scan(:,3)));
            rescheduled_operation = Scheduling_operation(remained_operation, arch);
            [r_rescheduled_operation, ~] = size(rescheduled_operation);
            for p = 1 :r_rescheduled_operation
                if double(rescheduled_operation(p,2)) < 1 && double(rescheduled_operation(p,2))~=0
                    rescheduled_operation(p,2) = '0';
                end
            end
            %%Remained operation 에서 0초에 시작하는 operator 들 중에서 random으로 하나를 정하는 과정
            test_vector=find(double(rescheduled_operation(:,2)) == 0);
            %class(double(rescheduled_operation(:,2)))
            % 간혹가다가 0.0000000001 같은 숫자가 발생
            
            % 섞어주는 과정
            random_value = randi(length(test_vector));
            temp_memory_name = rescheduled_operation(random_value,1);
            temp_memory_starting = rescheduled_operation(random_value,2);
            temp_memory_endtime = rescheduled_operation(random_value,3);
            for k = 1: 3
                rescheduled_operation(random_value,k) = rescheduled_operation(1,k);
            end
            rescheduled_operation(1,1) = temp_memory_name;
            rescheduled_operation(1,2) = temp_memory_starting;
            rescheduled_operation(1,3) = temp_memory_endtime;
            
            for k = 1: r_temp
                rescheduled_operation(k,2) = num2str(double(rescheduled_operation(k,2)) + double(final_operation(i,3)));
                rescheduled_operation(k,3) = num2str(double(rescheduled_operation(k,3)) + double(final_operation(i,3)));
            end
            %
            %fprintf("while 이전 rescheduled operation\n");
            %disp(rescheduled_operation)
            condition = true;
            while condition == true
                %rescheduled_operation;
                for k = 1: r_temp
                    rescheduled_operation(k,2) = string(double(rescheduled_operation(k,2))-1);
                    rescheduled_operation(k,3) = string(double(rescheduled_operation(k,3))-1);
                end
                if double(rescheduled_operation(1,2))<0
                    %fprintf("이 경우 final(k,:)\n")
                    disp('error!!!!!')
                    pause;
                end
                for t = 1: r_temp
                    for k = 1: j-1
                        if Is_possible (rescheduled_operation(t,:), final_operation(k,:), init_placement, 'pro1') =='N'
                            condition = false;
                            break;
                        end
                    end
                    if condition==false
                        break
                    end
                end
                %condition = all(ismember(temp2, 'Y'));
            end
            for k = 1: r_temp
                rescheduled_operation(k,2) = num2str(double(rescheduled_operation(k,2))+1);
                rescheduled_operation(k,3) = num2str(double(rescheduled_operation(k,3))+1);
            end

            final_operation(1:j-1,:) = final_operation(1:j-1,:);
            final_operation(j:j+r_temp-1,:) = rescheduled_operation(1:r_temp,:);
            
        else
            
        end
    end
end
endtime = max(str2double(final_operation(:,3)));


end