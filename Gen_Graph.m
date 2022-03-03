function output = Gen_Graph(placement, arch)%], Node_distance)
    if arch=='t-arch'
        s = [];
        t = [];
        for i = 1 :max(max(placement))
            [r1,c1] = find(placement==i);
            for j = i+1:max(max(placement))
                [r2,c2] = find(placement==j);
                if abs(r1-r2)^2+abs(c1-c2)^2 <= 2
                    if (r1-r2) == -1 && (c1-c2)==1
                    elseif (r1-r2) == 1&&(c1-c2)==-1
                    else
                        s = [s placement(r1, c1)];
                        t = [t placement(r2, c2)];
                    end
                end

            end
        end
        output = graph(s,t);
    elseif arch=='c-arch'
        s= [];
        t= [];
        for i = 1:max(max(placement))
            [r1,c1] = find(placement ==i);
            for j= i+1:max(max(placement))
                [r2,c2] = find(placement==j);
                if abs(r1-r2)^2 + abs(c1-c2)^2 == 2 || abs(r1-r2)^2 + abs(c1-c2)^2 == 0
                    s = [s placement(r1, c1)];
                    t = [t placement(r2, c2)];
                end
            end
        end
        output = graph(s,t);
    end

end