import os

import numpy as np


class Agent():
    def __init__(self):
        pass

    def save_q_table(self, q_table):
        # Ensure the directory exists
        os.makedirs(os.path.dirname(self.q_table_path), exist_ok=True)
        np.save(self.q_table_path, q_table)
        print(f"Q-table saved to {self.q_table_path}")

    def load_q_table(self):
        if os.path.exists(self.q_table_path):
            self.q_table = np.load(self.q_table_path)
            print(f"Q-table loaded from {self.q_table_path}")