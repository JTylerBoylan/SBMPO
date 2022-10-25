%% SBMPO Results Visualizer
clear
close all
clc

% Get results from csv
plans = results("../results/book_model_results.csv");

% Set obstacles
obstacles = [3.1, 2.5, 0.5;
             3.5, 3.7, 0.5;
             1.0, 0.5, 0.5];

% Convert path states to points and plot
for p = 1:length(plans)

    figure
    hold on
    grid on
    axis([-2.5 7.5 -2.5 7.5])

    title(strcat("Results ", int2str(p)))
    xlabel("X (m)")
    ylabel("Y (m)")

    % Plot path
    px = zeros(1, plans.path_size);
    py = zeros(1, plans.path_size);
    for n = 1:plans.path_size
        node = plans.nodes(plans.path(n) + 1);
        px(n) = node.state(1);
        py(n) = node.state(2);
    end
    plot (px, py, '-b', LineWidth=3)

    % Plot all nodes
    bx = zeros(1, plans.buffer_size);
    by = zeros(1, plans.buffer_size);
    for b = 1:plans.buffer_size
        node = plans.nodes(b);
        bx(b) = node.state(1);
        by(b) = node.state(2);
    end
    plot (bx, by, 'xk', MarkerSize=2)

    % Plot obstacles
    obstacles(:,1:2) = obstacles(:,1:2) - obstacles(:,3);
    obstacles(:,3) = obstacles(:,3) .* 2;
    for o = 1:length(obstacles)
        pos = [obstacles(o,1:2) obstacles(o,3) obstacles(o,3)];
        rectangle(Position=pos, Curvature=[1,1])
    end

end