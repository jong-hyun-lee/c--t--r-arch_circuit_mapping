function [final_operation, endtime]=  Routing_operation_prop1_window(init_operation, arch, init_placement, window_size)
[r_operation, ~] = size(init_operation);
num_window = ceil(r_operation/window_size);
Result  = [];
endtime_window = 0;
for window = 1: num_window   
    if window*window_size > r_operation
        operation_window = init_operation(1+(window-1)*window_size:r_operation,:);
    else
        operation_window = init_operation(1+(window-1)*window_size:window*window_size,:);
    end
    min_window = min(double(operation_window(:,2))) ;
    if min_window ~= 0
        %operation_window
        operation_window(:,2) = string(double(operation_window(:,2))-min_window);
        operation_window(:,3) = string(double(operation_window(:,3))-min_window);
    end
    %disp("operation_window 는 :")
    %operation_window
    [Routed_operation_window, end_time] = Routing_operation_proposal1(operation_window, arch, init_placement);
    [r_Routed_operation_window, ~] = size(Routed_operation_window);
    %Routed_operation_window
    for i = 1: r_Routed_operation_window
        Routed_operation_window(i,2) = string(double(Routed_operation_window(i,2))+ endtime_window);
        Routed_operation_window(i,3) = string(double(Routed_operation_window(i,3))+ endtime_window);
    end
    Result = [Result;   Routed_operation_window];
        
    endtime_window=endtime_window+end_time;
    
end
final_operation = Result;
endtime = endtime_window;
end