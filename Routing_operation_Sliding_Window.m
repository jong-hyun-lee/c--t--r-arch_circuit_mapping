%% 해당 부분부터 알고리즘 진행
function [Routed_operation, Endtime] = Routing_operation_Sliding_Window(init_operation, arch, init_placement, window_size)
[~,~,~,cycles_SWAP,~, ~] = all_operaiton_time(arch);
moved_placement = init_placement;
[r_init,~] = size(init_operation);
len_window = min(window_size,r_init);
B(1:len_window,:) = init_operation(1:len_window,:);
R_operation = [];
init_operation_number  = len_window; %init operation 중 수행중인 것의 갯수(처음에는 당연히 len_window로 잡음)
r_placement= init_placement;

num= 0;
while 1
    Scheduled_operation = cell(1,1);
    if isempty(B)
        break;
    else
        %% Routing 된 operation을 저장하려고 함
        [B_length, ~] = size(B);
        for index =1 : ceil(B_length/2)
            %fprintf('B (%d) 는 %s %s %s \n',index, string(B(1,:)));
            
            if index ==1
                temporary_placement = r_placement; %현재 initplacement + r 로 생성된 placement
            else
                temporary_placement = moved_placement;
            end
            %fprintf('NN 여부 : %s ',is_NN(B(index,:), temporary_placement, arch));
            
            if is_NN(B(index,:), temporary_placement, arch) =='Y'
                if string(B(index,1))=='S'
                    temp = temporary_placement;
                    [a,b] = find(temp==str2double(B(index,2)));
                    [c,d] = find(temp==str2double(B(index,3)));
                    temporary_placement(a,b) = temp(c,d);
                    temporary_placement(c,d) = temp(a,b);
                    %fprintf('B(%d) 는 Swap\n', index);
                    %fprintf('temp 는\n')
                    %disp(temp)
                    %tempoary_placement
                end
                moved_placement = temporary_placement;
                
                
                if index == ceil(B_length/2)
                    %fprintf('NN의 B로만 구성되어있고, index %d 는 B (길이 : %d) 의  마지막\n', index, ceil(B_length/2))
                    R_operation = [R_operation; B(1,:)];
                    updated_B = [];
                    
                    if init_operation_number+1<=r_init
                        updated_B = [B(2:end,:); init_operation(init_operation_number+1,:)];
                        
                    else
                        updated_B = B(2:end,:);
                    end
                    
                    if string(B(1,1))=='S' %%해당구문을 r_placement로 받아야 함.
                        temp= r_placement;
                        [a,b] = find(temp==str2double(B(1,2)));
                        [c,d] = find(temp==str2double(B(1,3)));
                        r_placement(a,b) = temp(c,d);
                        r_placement(c,d) = temp(a,b);
                    end
                    [len_updated_B ,~] = size(updated_B);
                    B = [];
                    if len_updated_B<=window_size
                        B = updated_B;
                        init_operation_number = init_operation_number+1;
                    else
                        B = updated_B(1:len_updated_B-1,:);
                    end
                    num = init_operation_number;
                %fprintf('r_placement :  \n')
                %disp(r_placement)
                end
                
                
            else
                [r1_operation,c1_operation] = find(temporary_placement==str2double(B(index,2)));
                [r2_operation,c2_operation] = find(temporary_placement==str2double(B(index,3)));
                
                % fprintf('Not_NN case %d\n',index)
                %fprintf('B (%d) 는 %s %s %s \n',index, string(B(index,:)));
                
                source = temporary_placement(r1_operation,c1_operation);
                dest = temporary_placement(r2_operation,c2_operation);
                G= Gen_Graph(temporary_placement, arch);
                [~,spath] = BellmanFord(G, source); % non-NN 연산에서 SWAP 을 위한 Shortest path 를 찾음
                spk = spath{dest}; %spk 는 source 에서 dest 까지 shortest path를 구함(array 형태로 출력), spath 는 모든 node 로의 shotrest path (여러개의 shortest_path가 존재 가능)
                
                % index가 바뀔 때 지속적으로 reset 되어야 할 변수 선언
                Candidate_all = cell(1,1);
                Scheduled_Candidate_added = "";
                Endtime_Candidate = [];
                Candidate_placement = [];
                
                for i=1: length(spk) %% 다양한 shortest path에 대한 구문 /// % 삭제 필요
                    candidate_shorest_path=spk{i};
                    len = length(candidate_shorest_path);
                    for j = 0 : len-2 % 각각 shortest path에 대하여, operation이 수행되는 지점을 정하는 parameter j
                        % 경로가 바뀔 때, 지속적으로 reset 되어야 할 변수 선언
                        SWAP = cell(1,1);
                        B_SWAP_added = cell(1,1);
                        
                        %SWAP의 수는 len-2 로 정해져 있으며, 해당 SWAP을 생성하는 과정
                        for k = 1 : j
                            SWAP(k,1) = cellstr('S');
                            SWAP(k,2) = cellstr(string(candidate_shorest_path(1)));
                            SWAP(k,3) = cellstr(string(candidate_shorest_path(1+k)));
                        end
                        for k = j+1 : len-2
                            SWAP(k,1) = cellstr('S');
                            SWAP(k,2) = cellstr(string(candidate_shorest_path(len)));
                            SWAP(k,3) = cellstr(string(candidate_shorest_path(len-k+j)));
                        end
                        [r_scheduled_operation, c_scheduled_operation] = size(Scheduled_operation);
                        if c_scheduled_operation ~= 1
                            B_SWAP_added = Scheduled_operation(1:r_scheduled_operation,:);
                            B_SWAP_added(r_scheduled_operation+1:r_scheduled_operation+len-2,:) = SWAP(1:len-2,:);
                            B_SWAP_added(r_scheduled_operation+len-1,:)=B(index,:);
                        else
                            B_SWAP_added = B(1:index-1,:);
                            B_SWAP_added(index:index+len-3,:) = SWAP(1:len-2,:);
                            B_SWAP_added(index+len-2,:)=B(index,:);
                        end
                        
                        % 모든 경우의 수를 Candidate all에 받음
                        [r_B_SWAP_added, ~] = size(B_SWAP_added);
                        for n1 = 1: r_B_SWAP_added
                            for n2 = 1: 3
                                Candidate_all(n1,n2,i,j+1) = B_SWAP_added(n1,n2);
                            end
                        end
                        
                        % Scheduling 된 Candidate 및 각 Candidate 의 0-ins 까지의 Endtime, Candidate 으로 SWAP을 수행 했을 경우의 배치를 저장
                        Scheduled_Candidate=Scheduling_operation(Candidate_all(:,:,i,j+1), arch);
                        Scheduled_Candidate_time_alinging = time_aligning(Scheduled_Candidate);
                        [r_temp2, c_temp2] = size(Scheduled_Candidate_time_alinging);
                        for n1 = 1 : r_temp2
                            for n2 = 1:c_temp2
                                Scheduled_Candidate_added(n1,n2,i,j+1) = Scheduled_Candidate_time_alinging(n1,n2);
                            end
                        end
                        Endtime_Candidate(i,j+1) = max(str2double(Scheduled_Candidate_added(:,3,i,j+1))); %% Look-back 의 결과물
                        Candidate_placement(:,:,i,j+1) = temporary_placement(:,:);
                        
                        % 여기서 부터  look-ahead 수행.
                        for n1 = 1: len-2 % p에 따른 placement 작성
                            temp(:,:) = Candidate_placement(:,:,i,j+1);
                            if char(SWAP(n1,1)) == 'S'
                                [a,b] = find(temp==str2double(SWAP(n1,2)));
                                [c,d] = find(temp==str2double(SWAP(n1,3)));
                                Candidate_placement(a,b,i,j+1) = temp(c,d);
                                Candidate_placement(c,d,i,j+1) = temp(a,b);
                            end
                        end
                        for k = index +1 :B_length
                            if is_NN(B(k,:), Candidate_placement(:,:,i,j+1), arch)== 'N'
                                G2 = Gen_Graph(Candidate_placement(:,:,i,j+1), arch);
                                [d2,~] = BellmanFord(G2, str2double(B(k,2)));
                                Endtime_Candidate(i,j+1) = Endtime_Candidate(i,j+1) + (d2(str2double(B(k,3)))-1)*cycles_SWAP; %% 해당 SWAP cycle의 수도 고쳐져야 함
                            end
                        end
                        % 이 때 Endtime_Candidate 는 look ahead를 포함한 Endtime 을 받음.
                    end
                end
                %여기까지 모든 가능한 경우의 수를 찾음.
                [r1_Endtime,r2_Endtime] = find(Endtime_Candidate == min(min(Endtime_Candidate))); %r_Endtime 가장 최소한의 시간에 끝나는 경우의 수를 의미
                random = randi(length(r1_Endtime));
                [r_B_candidate,~] = size(Scheduled_Candidate_added(:,:,r1_Endtime(random),r2_Endtime(random))); %r_B 는 최소한의 시간에 끝나는 Scheduled output을 의미
                %moved_placement = Candidate_placement(:,:,r1_Endtime(random),r2_Endtime(random));
                %
                for i=1: r_B_candidate
                    for j = 1:3
                        Scheduled_operation(i,j) =Candidate_all(i,j,r1_Endtime(random),r2_Endtime(random));
                    end
                end
                
                %fprintf('최소한의 길이를 갖는 Scheduled operation 은 : \n')
                %disp(Scheduled_operation)
                
                R_operation = [R_operation; Scheduled_operation(1,:)];
                if string(Scheduled_operation(1,1))=='S'
                    temp = r_placement;
                    [a,b] = find(temp==str2double(Scheduled_operation(1,2)));
                    [c,d] = find(temp==str2double(Scheduled_operation(1,3)));
                    r_placement(a,b) = temp(c,d);
                    r_placement(c,d) = temp(a,b);
                    %tempoary_placement
                end
                
                %fprintf('r_placement :  \n%d %d %d \n%d %d %d \n%d %d %d \n', r_placement)
                
                updated_B = [];
                
                % 여기서 부터 B 업데이트(B는 loop를 끝내기 전에만 update 함)
                % loop(index)를 끝내는 경우는 1. non-NN operation이 나왔을 경우,
                %2. B가 NN으로만 구성되어 마지막 경우(index)에 도달했을 경우
                if init_operation_number+1 <= r_init
                    updated_B = [Scheduled_operation(2:end,:); B(index+1:end,:);  init_operation(init_operation_number+1,:)];
                    [len_updated_B ,~] = size(updated_B);
                    if len_updated_B<= window_size
                        B = updated_B;
                        init_operation_number= init_operation_number+1;
                    else
                        B = updated_B(1:len_updated_B-1,:);
                    end
                    
                else
                    updated_B = [Scheduled_operation(2:end,:);B(index+1:end,:)];
                    B = updated_B;
                end
                
                %fprintf('새롭게 생성된 B 는\n')
                num = init_operation_number;
                break;
                
                
                
            end
        end
        
    end
end
R_operation;
%R_operation
Routed_operation = Scheduling_operation_edge_type1_final(R_operation, arch);
Endtime = max(double(Routed_operation(:,3)));
end













%[Routed_operation, Endtime] = Routing_operation_window(init_operation, arch, init_placement, 10);
%Scheduled_operation = time_aligning(Scheduling_operation(operation_cell, arch));
%        for i = 1 :length(Scheduled_operation)
%            init_operation(i,:) = cellstr(strsplit(Scheduled_operation(i,1), ' '));
%        end
%        [Routed_operation, Endtime] = Routing_operation_prop1_window(init_operation, arch, init_placement, 10);