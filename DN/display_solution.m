function steps = display_solution(Q, klet)
% Displays the greedy solution path based on the Q-table
% Q      - Q-table (numStates x 4)
% klet   - Grid environment matrix
% steps  - Number of steps taken to reach the goal

[n, ~] = size(klet);
goal_state = sub2ind([n, n], n, n);
state = 1;  % Start state is always at (1,1)
path = state;

actions = [0 -1;  % LEFT
           1  0;  % DOWN
           0  1;  % RIGHT
          -1  0]; % UP

% Follow greedy policy until goal or loop limit
max_path_length = n^2; % just in case
for i = 1:max_path_length
    [~, action] = max(Q(state, :));
    [row, col] = ind2sub([n n], state);
    move = actions(action, :);
    new_row = row + move(1);
    new_col = col + move(2);

    % Check bounds
    if new_row < 1 || new_row > n || new_col < 1 || new_col > n
        warning("Out of bounds detected. Aborting.");
        break;
    end

    % Check wall
    if klet(new_row, new_col) == -n
        warning("Hit a wall. Aborting.");
        break;
    end

    new_state = sub2ind([n n], new_row, new_col);

    % Check loop
    if ismember(new_state, path)
        warning("Loop detected. Aborting.");
        break;
    end

    path(end+1) = new_state;
    state = new_state;

    if state == goal_state
        break;
    end
end

% Plot map
figure;
imagesc(klet);
colormap(copper);
axis equal off;
title('Greedy Policy Path Based on Q-table');
hold on;

% Draw path
for k = 1:length(path)
    [r, c] = ind2sub([n n], path(k));
    plot(c, r, 'ko', 'MarkerFaceColor', 'cyan');
end

% Start and goal
[r_start, c_start] = ind2sub([n n], path(1));
[r_goal, c_goal] = ind2sub([n n], path(end));
plot(c_start, r_start, 'go', 'MarkerFaceColor', 'green'); % Start
plot(c_goal, r_goal, 'ro', 'MarkerFaceColor', 'red');     % Goal

hold off;

steps = length(path) - 1;
fprintf("Steps to reach goal: %d\n", steps);
end
