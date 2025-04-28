function action = sampleRandomAction()
    bins = [-0.0627, -0.0427, -0.0227, 0, 0.0227, 0.0427, 0.0627];

    ux = bins(randi(length(bins)));
    uy = bins(randi(length(bins)));
    uz = bins(randi(length(bins)));

    action = [ux, uy, uz];
end
