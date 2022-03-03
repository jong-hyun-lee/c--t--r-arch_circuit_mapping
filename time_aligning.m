%% Time 순서로 정렬

function output = time_aligning(test_vector)
[answer,index] = sort(str2double(test_vector(:,2)),'ComparisonMethod','real');
for i = 1:length(index)
    time_after(i,:) = test_vector(index(i),:);
end
output = time_after;
end