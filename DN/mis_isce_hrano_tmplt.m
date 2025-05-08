%% Create env
vpisna_stevilka = 64240417;
rng(vpisna_stevilka) 
n = 256;

klet = -1*ones(n,n);

for i=1:n
    for j=1:n
        if (rand() < 0.25)
            klet(i,j) = -n;
        end
    end
end
klet(1,1) = -1;
klet(1,2) = -1;
klet(2,1) = -1;
klet(2,2) = -1;
klet(n-1,n-1) = -1;
klet(n,n-1) = -1;
klet(n-1,n) = -1;
klet(n,n) = n;

% Render environment
disp(klet);

%%

visualize_klet(klet);


%%
fh = figure;
imagesc(klet);
colormap(copper);

for i=1:n
    for j=1:n
        
        if (i==1) && (j == 1)
            text(1,1,{'1','START'},'HorizontalAlignment','center');
        elseif (i==n) && (j==n)
            text(n,n,{num2str(n*n),'GOAL'},'HorizontalAlignment','center');
        else
            text(j,i,num2str(i+n*(j-1)),'HorizontalAlignment','center');
        end
    end
end

axis off

%%
%Vaša koda

env = BoardEnv(klet);

no_episodes = 10000;
alpha = 0.5;
gamma = 0.9;
epsilon = 1;
max_steps= 48000;

visualise = false;

Q = q_learning(env, no_episodes, alpha, gamma, epsilon, max_steps,visualise);
steps = display_solution(Q, klet);

%%
% Vizualizacija rešitve
indexQ = int32([(1:(n*n))]');
visQ = table(indexQ,Q)

num_steps = vizualizacija_Q4(Q, klet);
num_steps = visualization_Q_arrows4(Q, klet);

