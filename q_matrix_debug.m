for i = 1:50
    for j = 1:50
        for k = 1:3
            for l = 1:5
                for m = 1:5
                    for n = 1:5
                        value = Q_pos(i,j,k,l,m,n); 
                        if value ~= 0
                            disp(['q value location ', num2str(Q_pos(i,j,k,l,m,n)), 'At index', num2str(i), num2str(j), num2str(k), num2str(l), num2str(m), num2str(n)]);
                        end
                    end
                end
            end
        end
    end
end
