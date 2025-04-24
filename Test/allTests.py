from Train import Train

env_name = 'CliffWalking-v0'
trainer = Train(env_name)

# cliff parameters

lr = 0.1
discount_factor = 0.95
epochs = 1000
maxSteps = 99
epsilon = 1

trainer.cliff_train(lr,discount_factor,epochs,maxSteps,epsilon)
trainer.cliff_test(show_q=True)

