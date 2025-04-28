function best_action = selectBestAction(Q,s)
    bins = [-0.0627, -0.0427, -0.0227, 0, 0.0227, 0.0427, 0.0627];

    maxQ = -Inf;
    best_idx = [1,1,1];

    for a1 = 1:6
        for a2 = 1:6
            for a3 = 1:6
                qval = Q(s(1), s(2), s(3), s(4), s(5), s(6), a1, a2, a3);
                if qval > maxQ
                    maxQ = qval;
                    best_idx = [a1, a2, a3];
                end
            end
        end
    end

    best_action = [bins(best_idx(1)), bins(best_idx(2)), bins(best_idx(3))];
end