function all_final_placement=proposal1_placement_operation_sorting(layout_size, operation_cell)



[r1,~] = size(operation_cell);
num_operation = zeros(layout_size,1);
for i= 1:r1
    if string(operation_cell(i,1))=='C' || string(operation_cell(i,1))=='S'
        num_operation(str2double(string(operation_cell(i,2)))) = num_operation(str2double(string(operation_cell(i,2))))+1;
        num_operation(str2double(string(operation_cell(i,3)))) = num_operation(str2double(string(operation_cell(i,3))))+1;
    end
end
[result, index] = sort(num_operation);
random_index = [];
for j = min(result) : max(result)
    a = find(result==j);
    if ~isempty(a)
        temp_index = index(min(a):max(a));
        random_vector = randperm(length(a));
        random_temp_index= temp_index( random_vector,:);
        random_index = [random_index; random_temp_index];
    end
end

final = zeros(1,layout_size);

for i = 0 : ceil(layout_size/2)-1
    final(ceil(layout_size/2)-i) = random_index(layout_size-2*i);
end
for i = 1 : floor(layout_size/2) 
    final(ceil(layout_size/2)+i) = random_index(layout_size-2*i+1);
end

all_final_placement = final;

end