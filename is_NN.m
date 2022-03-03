%% t-arch 용
function output = is_NN(operation, placement, arch)
    if arch == 't-arch'
        [r1,c1] = find(placement==str2double(operation(1,2)));
        [r2,c2] = find(placement==str2double(operation(1,3)));
        if abs(r1-r2)^2+abs(c1-c2)^2 <= 2
            if (r1-r2) == -1 && (c1-c2)==1
                output = 'N';
            elseif (r1-r2) == 1&&(c1-c2)==-1
                output = 'N';
            else
                output = 'Y';
            end
        else
            output = 'N';
        end
    elseif arch =='c-arch'
        [r1,c1] = find(placement==str2double(operation(1,2)));
        [r2,c2] = find(placement==str2double(operation(1,3)));
        if abs(r1-r2)^2 + abs(c1-c2)^2 == 2 || abs(r1-r2)^2 + abs(c1-c2)^2 == 0
            output = 'Y';
        else
            output = 'N';
        end
    end
end
