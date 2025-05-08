function visualize_klet(klet)
    % klet: the environment matrix (n x n)
    % values:
    %   -n = wall
    %   -1 = free space
    %   n  = goal
    % Start is always assumed at (1,1)

    n = size(klet, 1);

    % Prepare color-coded matrix
    color_map = zeros(n); % base: empty

    for i = 1:n
        for j = 1:n
            if i == 1 && j == 1
                color_map(i,j) = 1; % START
            elseif klet(i,j) == -n
                color_map(i,j) = 2; % WALL
            elseif klet(i,j) == n
                color_map(i,j) = 3; % GOAL
            else
                color_map(i,j) = 4; % FREE
            end
        end
    end

    % Show image
    figure;
    imagesc(color_map);
    axis equal off;
    title('Environment Grid (Color View)');

    % Custom colormap: START, WALL, GOAL, FREE
    cmap = [
        0   0.8 0;    % green      - START
        0.3 0.3 0.3;  % dark gray  - WALL
        1   0   0;    % red        - GOAL
        1   1   1     % white      - FREE
    ];
    colormap(cmap);
end
