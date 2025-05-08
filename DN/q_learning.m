function Q = q_learning(env, no_episodes, alpha, gamma, epsilon, max_steps, visualise)
% Q-learning with live visualization of the agent
% Inputs and outputs are the same as before

% Initialize Q-table
num_states = env.NumStates;
num_actions = env.NumActions;
Q = zeros(num_states, num_actions);

% Set up visualization
n = env.StateSize(1);
if visualise
    figure('Name','Q-learning Live Visualization');
    imagesc(env.Klet);
    colormap(copper);
    axis equal tight off;
    title('Agent Training Progress');
    hold on;
    
    % Draw goal
    plot(env.GoalPos(2), env.GoalPos(1), 'ro', 'MarkerSize', 12, 'LineWidth', 2);
    
    % Agent marker
    agent_dot = plot(env.StartPos(2), env.StartPos(1), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
end

reached_goal = 0;

first_done = 0;
lowest_to_goal = Inf;

for ep = 1:no_episodes
    state = env.reset();
    [row, col] = env.state2pos(state);
    if visualise
        set(agent_dot, 'XData', col, 'YData', row);
        drawnow;
    end

    done = false;
    step_count = 0;

    while ~done && step_count < max_steps
        step_count = step_count + 1;

        % Epsilon-greedy action
        if rand < epsilon
            action = randi(num_actions);
        else
            [~, action] = max(Q(state, :));
        end

        % Step and observe
        [next_state, reward, done] = env.step(action);

        % Q-learning update
        Q(state, action) = Q(state, action) + alpha * ...
            (reward + gamma * max(Q(next_state, :)) - Q(state, action));
        if visualise
            % Move agent visually
            [row, col] = env.state2pos(next_state);
            set(agent_dot, 'XData', col, 'YData', row);
            drawnow;
            pause(0.05);  % slow down animation slightly
    
            
        end
        state = next_state;
    end

    if done
        reached_goal = reached_goal + 1;

        if lowest_to_goal > step_count
            lowest_to_goal = step_count;
        end

        if first_done == 0
            first_done = ep;
        end
    end
end

fprintf('Reached goal in %d / %d episodes\n First reached goal in episode %d\n Lowest steps until reaching goal: %d\n', reached_goal, no_episodes, first_done, lowest_to_goal);
end
