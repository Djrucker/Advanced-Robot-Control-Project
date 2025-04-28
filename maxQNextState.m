function maxQ = maxQNextState(Q, s)
    maxQ = -Inf;
    for a1 = 1:6
        for a2 = 1:6
            for a3 = 1:6
                q = Q(s(1), s(2), s(3), s(4), s(5), s(6), a1, a2, a3);
                if q > maxQ
                    maxQ = q;
                end
            end
        end
    end
end