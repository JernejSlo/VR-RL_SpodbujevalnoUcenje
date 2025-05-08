classdef BoardEnv < handle
    properties
        Klet             % Matrix representing the environment
        NumStates        % Total number of states
        NumActions = 4   % LEFT, DOWN, RIGHT, UP
        StateSize        % Size of the grid [rows, columns]
        CurrentPos       % Current [row, col] position
        GoalPos          % [row, col] of goal
        StartPos         % [row, col] of start
    end

    methods
        function obj = BoardEnv(klet)
            obj.Klet = klet;
            obj.StateSize = size(klet);
            obj.NumStates = prod(obj.StateSize);
            obj.StartPos = [1, 1];
            obj.GoalPos = [obj.StateSize(1), obj.StateSize(2)];
            obj.CurrentPos = obj.StartPos;
        end

        function state = reset(obj)
            obj.CurrentPos = obj.StartPos;
            state = obj.pos2state(obj.CurrentPos);
        end

        function [next_state, reward, done] = step(obj, action)
            % Define actions: [dRow, dCol]
            switch action
                case 1 % LEFT
                    move = [0 -1];
                case 2 % DOWN
                    move = [1 0];
                case 3 % RIGHT
                    move = [0 1];
                case 4 % UP
                    move = [-1 0];
                otherwise
                    error('Invalid action: must be 1-4');
            end
        
            pos = obj.CurrentPos;
            new_pos = pos + move;
        
            % --- Out-of-bounds check ---
            if new_pos(1) < 1 || new_pos(1) > obj.StateSize(1) || ...
               new_pos(2) < 1 || new_pos(2) > obj.StateSize(2)
                % Attempted move out of grid → harsh penalty
                %disp("OUT OF BOUNDS!");
                new_pos = max([1 1], pos);

                reward = -10;
                done = false;
        
            elseif obj.Klet(new_pos(1), new_pos(2)) == -obj.StateSize(1)
                % Wall → penalty
                %disp("Hit wall");
                new_pos = pos;
                reward = -3;
                done = false;
        
            elseif isequal(new_pos, obj.GoalPos)
                % Reached goal
                %disp("Reached goal");
                reward = 10;
                done = true;
        
            else
                % Regular valid move
                %disp("Made random move");
                reward = -0.5;
                done = false;
            end
        
            obj.CurrentPos = new_pos;
            next_state = obj.pos2state(new_pos);
        
            % Debug output
            %disp("################");
            %disp("Action: " + action);
            %disp("Reward: " + reward);
            %disp("Next state: " + next_state);
            %pause(0.1);
        end


        function s = pos2state(obj, pos)
            % Convert [row, col] to linear index
            s = sub2ind(obj.StateSize, pos(1), pos(2));
        end

        function [row,col] = state2pos(obj, s)
            % Convert linear index to [row, col]
            [row, col] = ind2sub(obj.StateSize, s);
        end
    end
end
