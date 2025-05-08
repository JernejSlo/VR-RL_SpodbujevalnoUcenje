classdef SimpleEnv
    properties
        NumStates = 6;
        NumActions = 2; % 1 = right, 2 = left
        CurrentState
        TerminalState = 6;
    end
    
    methods
        function obj = SimpleEnv()
            obj.CurrentState = 1;
        end
        
        function state = reset(obj)
            obj.CurrentState = 1;
            state = obj.CurrentState;
        end
        
        function [next_state, reward, done] = step(obj, action)
            if action == 1 % move right
                obj.CurrentState = min(obj.CurrentState + 1, obj.NumStates);
            elseif action == 2 % move left
                obj.CurrentState = max(obj.CurrentState - 1, 1);
            end

            next_state = obj.CurrentState;
            reward = double(next_state == obj.TerminalState);
            done = (next_state == obj.TerminalState);
        end
    end
end