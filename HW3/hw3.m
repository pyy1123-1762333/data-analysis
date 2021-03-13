% clear all; close all; clc

% load all the movies
load('cam1_1.mat')
load('cam1_2.mat')
load('cam1_3.mat')
load('cam1_4.mat')
load('cam2_1.mat')
load('cam2_2.mat')
load('cam2_3.mat')
load('cam2_4.mat')
load('cam3_1.mat')
load('cam3_2.mat')
load('cam3_3.mat')
load('cam3_4.mat')


% Test 1: Ideal case ------------------------------------------------------
% size of matrix for cam1_1: 480x640
% f1 = zeros(480, 640);
% % range of valid data
% f1(200:450, 280:400) = 1;
% cam1 = process_data(vidFrames1_1, f1, 240);
% 
% % size of matrix for cam2_1: 480x640
% f2 = zeros(480, 640);
% % range of valid data
% f2(80:400, 220:350) = 1;
% cam2 = process_data(vidFrames2_1, f2, 240);
% 
% % size of matrix for cam3_1: 480x640
% f3 = zeros(480, 640);
% % range of valid data
% f3(220:340, 250:500) = 1;
% cam3 = process_data(vidFrames3_1, f3, 240);
% 
% 
% data = get_data(cam1, cam2, cam3);
% 
% % Use SVD
% [M, N] = size(data);
% data = data - repmat(mean(data, 2), 1, N);
% [U, S, V] = svd(data'/sqrt(N - 1));
% sigma = diag(S).^2;
% Y = data' * V;
% 
% Plot the result
% figure(1)
% plot(1:6, sigma / sum(sigma), 'ro', 'Linewidth', 3);
% title('Case 1(Ideal Case): Variance Energy plot');
% xlabel('Variance');
% ylabel('Energy Percentage');
% 
% figure(2)
% plot(1:N, data(2,:), 1:N, data(1,:), 'Linewidth', 3);
% xlabel('Time');
% ylabel('Displacement');
% title('Case 1(Ideal Case): Displacement of Spring');
% legend('Z-axis', 'XY-plane');
% 
% figure(3)
% plot(1:N, Y(:, 1), 'Linewidth', 3);
% xlabel('Time');
% ylabel('Displacement');
% title('Case 1(Ideal Case): Displacement of Spring(Principle Component)');
% legend('PC_1');
% 
% 
% 
% % Test 2: Noisy case ------------------------------------------------------
% % size of matrix for cam1_2: 480x640
f1 = zeros(480, 640);
% range of valid data
f1(200:400, 300:440) = 1;
cam1 = process_data(vidFrames1_2, f1, 240);

% size of matrix for cam2_2: 480x640
f2 = zeros(480, 640);
% range of valid data
f2(50:410, 180:450) = 1;
cam2 = process_data(vidFrames2_2, f2, 240);

% size of matrix for cam3_2: 480x640
f3 = zeros(480, 640);
% range of valid data
f3(180:340, 270:470) = 1;
cam3 = process_data(vidFrames3_2, f3, 240);


data = get_data(cam1, cam2, cam3);

% Use SVD
[M, N] = size(data);
data = data - repmat(mean(data, 2), 1, N);
[U, S, V] = svd(data'/sqrt(N - 1));
sigma = diag(S).^2;
Y = data' * V;
% 
% % Plot the result
figure(4)
plot(1:6, sigma / sum(sigma), 'rx', 'Linewidth', 3);
title('Case 2(Noisy Case): Variance Energy plot');
xlabel('Variance');
ylabel('Energy Percentage');
% 
% figure(5)
% plot(1:N, data(2,:), 1:N, data(1,:), 'Linewidth', 3);
% xlabel('Time');
% ylabel('Displacement');
% title('Case 2(Noisy Case): Displacement of Spring');
% legend('Z-axis', 'XY-plane');
% 
% figure(6)
% plot(1:N, Y(:, 1), 1:N, Y(:, 2), 'g', 'Linewidth', 3);
% xlabel('Time');
% ylabel('Displacement');
% title('Case 2(Noisy Case): Displacement of Spring(Principle Component)');
% legend('PC_1', 'PC_2');
% 
% 
% 
% % Test 3: Horizontal Displacement -----------------------------------------
% % size of matrix for cam1_3: 480x640
% f1 = zeros(480, 640);
% % range of valid data
% f1(250:420, 200:390) = 1;
% cam1 = process_data(vidFrames1_3, f1, 240);
% 
% % size of matrix for cam2_3: 480x640
% f2 = zeros(480, 640);
% % range of valid data
% f2(170:380, 240:400) = 1;
% cam2 = process_data(vidFrames2_3, f2, 240);
% 
% % size of matrix for cam3_3: 480x640
% f3 = zeros(480, 640);
% % range of valid data
% f3(180:340, 240:480) = 1;
% cam3 = process_data(vidFrames3_3, f3, 240);
% 
% 
% data = get_data(cam1, cam2, cam3);
% 
% % Use SVD
% [M, N] = size(data);
% data = data - repmat(mean(data, 2), 1, N);
% [U, S, V] = svd(data'/sqrt(N - 1));
% sigma = diag(S).^2;
% Y = data' * V;
% 
% % Plot the result
% figure(7)
% plot(1:6, sigma / sum(sigma), 'rx', 'Linewidth', 3);
% title('Case 3: Variance Energy plot');
% xlabel('Variance');
% ylabel('Energy Percentage');
% 
% figure(8)
% plot(1:N, data(2,:), 1:N, data(1,:), 'Linewidth', 3);
% xlabel('Time');
% ylabel('Displacement');
% title('Case 3: Displacement of Spring');
% legend('Z-axis', 'XY-plane');
% 
% figure(9)
% plot(1:N, Y(:, 1), 1:N, Y(:, 2), 1:N, Y(:, 3), 1:N, Y(:, 4), 'g', 'Linewidth', 3);
% xlabel('Time');
% ylabel('Displacement');
% title('Case 3: Displacement of Spring(Principle Component)');
% legend('PC_1', 'PC_2', 'PC_3', 'PC_4');




% Test 4:Horizontal Displacement and Rotation -----------------------------
% size of matrix for cam1_4: 480x640
% f1 = zeros(480, 640);
% % range of valid data
% f1(230:450, 330:460) = 1;
% cam1 = process_data(vidFrames1_4, f1, 240);
% 
% % size of matrix for cam2_4: 480x640
% f2 = zeros(480, 640);
% % range of valid data
% f2(100:370, 230:420) = 1;
% cam2 = process_data(vidFrames2_4, f2, 240);
% 
% % size of matrix for cam3_4: 480x640
% f3 = zeros(480, 640);
% % range of valid data
% f3(140:280, 320:500) = 1;
% cam3 = process_data(vidFrames3_4, f3, 230);
% 
% 
% data = get_data(cam1, cam2, cam3);
% 
% % Use SVD
% [M, N] = size(data);
% data = data - repmat(mean(data, 2), 1, N);
% [U, S, V] = svd(data'/sqrt(N - 1));
% sigma = diag(S).^2;
% Y = data' * V;

% Plot the result
% figure(10)
% plot(1:6, sigma / sum(sigma), 'rx', 'Linewidth', 3);
% title('Case 4: Variance Energy plot');
% xlabel('Variance');
% ylabel('Energy Percentage');

% figure(11)
% plot(1:N, data(2,:), 1:N, data(1,:), 'Linewidth', 3);
% xlabel('Time');
% ylabel('Displacement');
% title('Case 4: Displacement of Spring');
% legend('Z-axis', 'XY-plane');
% 
% figure(12)
% plot(1:N, Y(:, 1), 1:N, Y(:, 2), 1:N, Y(:, 3), 'g', 'Linewidth', 3);
% xlabel('Time');
% ylabel('Displacement');
% title('Case 4: Displacement of Spring(Principle Component)');
% legend('PC_1', 'PC_2', 'PC_3');

