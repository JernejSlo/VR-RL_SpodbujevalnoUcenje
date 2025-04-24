from Utils.Agent import Agent
import gymnasium as gym ##
import numpy as np
import random
from time import sleep


class Train(Agent):
    def __init__(self,env_name):
        Agent.__init__(self)
        self.env_name = env_name


    def train_Q(self,lr,epochs,max_steps,fi,eta):
        pass

    def cliff_test(self):
        print(self.q_table)

        env = gym.make(self.env_name, render_mode="human")
        state = env.reset()
        state = state[0]  ##

        done = False
        trial_length = 0
        while not done:
            action = np.argmax(self.q_table[state])
            state, reward, terminated, truncated, info = env.step(action)  ##
            done = terminated or truncated  ##
            trial_length += 1
            print(" Step " + str(trial_length))
            env.render()
            sleep(.2)


    def cliff_train(self,learning_rate,discount_factor,epochs,max_steps,epsilon):
        env = gym.make(self.env_name, render_mode="rgb_array")
        env.reset()
        env.render()

        print("Observation space = ", env.observation_space.n)
        print("Actions = ", env.action_space.n)

        self.q_table = np.zeros([env.observation_space.n, env.action_space.n])
        # q_table = np.random.uniform(low=0, high=1, size=[env.observation_space.n, env.action_space.n])
        print("Q table size = ", self.q_table.shape)

        START_EPSILON_DECAYING = 1
        END_EPSILON_DECAYING = epochs // 2
        epsilon_decay_value = epsilon / (END_EPSILON_DECAYING - START_EPSILON_DECAYING)
        SHOW_EVERY = 100

        for episode in range(epochs):
            state = env.reset()
            state = state[0]  ##
            done = False

            trial_length = 0

            #while not done:
            for step in range(max_steps):
                if (random.uniform(0, 1) < epsilon):  # Exploration with random action
                    action = env.action_space.sample()
                else:  # Use the action with the highest q-value
                    action = np.argmax(self.q_table[state])

                next_state, reward, terminated, truncated, info = env.step(action)  ##
                done = terminated or truncated  ##

                curr_q = self.q_table[state, action]
                next_max_q = np.max(self.q_table[next_state])
                new_q = (1 - learning_rate) * curr_q + learning_rate * (reward + discount_factor * next_max_q)
                self.q_table[state, action] = new_q

                state = next_state

                if episode % SHOW_EVERY == 0:
                    trial_length += 1

                if done:
                    break

            if episode % SHOW_EVERY == 0:
                print(f'Episode: {episode:>5d}, episode length: {int(trial_length):>5d}')

            if END_EPSILON_DECAYING >= episode >= START_EPSILON_DECAYING:
                epsilon -= epsilon_decay_value
