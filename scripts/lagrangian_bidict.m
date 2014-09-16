

if ~exist('X1','var')
    load '/misc/vlgscratch3/LecunGroup/bruna/grid_data/spect_640/class_s31.mat'
    X1 = Xc;
    clear Xc;
    
    epsilon = 1;
    
    load '/misc/vlgscratch3/LecunGroup/bruna/grid_data/spect_640/class_s14.mat'
    X2 = Xc;
    
    X = [X1];
    
end

%renormalize data: whiten each frequency component.
eps=4e-1;
stds = std(X,0,2) + eps;
X = X./repmat(stds,1,size(X,2));
avenorm = mean(sqrt(sum(X.^2)));
X = X/avenorm;

gpud=gpuDevice(2);

param.nmf=1;
param.lambda=0.05;
param.beta=1e-2;
param.overlapping=1;
param.groupsize=4;
param.time_groupsize=4;
param.nu=0.2;
param.lambdagn=0.1;
param.betagn=0;
param.itersout=300;
param.K=128;
param.Kgn=64;
param.epochs=4;
param.batchsize=2048;
param.plotstuff=1;

reset(gpud);

[D, Dgn] = twolevelDL_gpu(X, param);

reset(gpud);

<<<<<<< HEAD
Xs = X(:,1:500);

[Z, Zgn,Poole] = twolevellasso_gpu(Xs, D, Dcut, param);
=======
[Z, Zgn] = twolevellasso_gpu(X, D, Dgn, param);
>>>>>>> f63a0b59704f713bb3532206e9e0acd0c82d52bf




