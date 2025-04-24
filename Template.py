import os

from Utils.Agent import Agent
import gymnasium as gym ##
import numpy as np
import random
from time import sleep
import matplotlib.pyplot as plt


class Template(Agent):
    def __init__(self,env_name):
        Agent.__init__(self)
        self.env_name = env_name
        self.q_table_path = os.path.join("TrainingData",env_name,"q_table.npy")


    def Test(self,**kwargs):
        self.load_q_table()

        # code



    def Train(self,learning_rate,discount_factor,epochs,max_steps,epsilon):

        # code

        self.save_q_table(self.q_table)
