%clear all; close all; clc;


%% load the video and reshape ---------------------------------------------
% change the video file name here
% vid1 = VideoReader('monte_carlo_low.mp4');
vid1 = VideoReader('ski_drop_low.mp4');
dt = 1 / vid1.Framerate;
t = 0:dt:vid1.Duration;
vidFrames = read(vid1);
numFrames = get(vid1, 'numberOfFrames');

for i = 1:numFrames
    mov(i).cdata = vidFrames(:, :, :, i);
    mov(i).colormap = [];
end

data = [];
for j = 1:numFrames
    X = frame2im(mov(j));
    X = double(rgb2gray(imresize(X, 0.25)));
    s = size(X);
    a = s(1);
    b = s(2);
    data = [data, reshape(X, [a*b,1])];
    
end

%% DMD - Dynamic Mode Decomposition ---------------------------------------
X1 = data(:, 1:end-1);
X2 = data(:, 2:end);

[U, S, V] = svd(X1, 'econ');
sig = diag(S);

% plot the energy and singular value
figure(1)
subplot(2, 1, 1)
plot(sig, 'b.', 'Linewidth', 0.5);
title("Singular Values"); 
ylabel("\sigma"); 

subplot(2, 1, 2)
plot(sig.^2 / sum(sig.^2), 'b.', 'Linewidth', 0.5)
title("Energy of Singular Values"); 
ylabel('Energy')

%% low-rank approximation -------------------------------------------------
rank = 1;

U_2 = U(:, 1:rank);
S_2 = S(1:rank, 1:rank);
V_2 = V(:, 1:rank);

% low-rank dynamics
Sigma = U_2' * X2 * V_2 * diag(1./diag(S_2));
[eV, D] = eig(Sigma);
mu = diag(D); % extract eigenvalues
omega = log(mu)/dt;
Phi = U_2*eV;

%% DMD reconstruction -----------------------------------------------------
y0 = Phi\X1(:,1);

u_modes = zeros(length(y0), length(t)-1);
for iter = 1:length(t)-1
    u_modes(:, iter) = y0.*exp(omega*t(iter));
end
u_dmd = Phi*u_modes;


% create sparse part
X_sparse = X1 - abs(u_dmd);
R = X_sparse.*(X_sparse < 0);

X_back = R + abs(u_dmd);
X_fore = X_sparse - R;

X_reconstruct = X_fore + X_back;


%% Comparison -------------------------------------------------------------
v = reshape(X1, [a, b, length(t)-1]);
v1 = reshape(X_sparse, [a, b, length(t)-1]);
v2 = reshape(u_dmd, [a, b, length(t)-1]);
v3 = reshape(X_back, [a, b, length(t)-1]);
v4 = reshape(X_fore, [a, b, length(t)-1]);
v5 = reshape(X_reconstruct, [a, b, length(t)-1]);


figure(2)
% num_frame = 100;
num_frame = 114;
subplot(2,3,1)
imshow(uint8(v(:,:,num_frame)))
title("Original Video");

subplot(2,3,2)
imshow(uint8(v1(:,:,num_frame)))
title("Sparse Reconstruction");

subplot(2,3,3)
imshow(uint8(v2(:,:,num_frame)))
title("Low Rank Reconstruction(No R)");

subplot(2,3,4)
imshow(uint8(v5(:,:,num_frame)))
title("Reconstruction");

subplot(2,3,5)
imshow(uint8(v4(:,:,num_frame)))
title("Sparse Reconstruction(R-)");

subplot(2,3,6)
imshow(uint8(v3(:,:,num_frame)))
title("Low Rank Reconstruction(R+)");
