% Clean workspace
clear all; close all; clc

% Imports the data as the 262144x49 (space by time) matrix called subdata
load subdata.mat 

L = 10; % spatial domain
n = 64; % Fourier modes
x2 = linspace(-L, L, n+1); 
x = x2(1:n); % only use the first n points
y = x; 
z = x;
k = (2*pi/(2*L))*[0:(n/2 - 1) -n/2:-1]; 
ks = fftshift(k);

[X,Y,Z] = meshgrid(x, y, z);
[Kx,Ky,Kz] = meshgrid(ks, ks, ks);


% PART 1: Average the spectrum, determine the center frequency. -----------
u_ave = zeros(n, n, n);

for i = 1:49
    Un(:,:,:)=reshape(subdata(:,i), n, n, n);
    unt = fftn(Un);
    u_ave = u_ave + unt;
end
u_ave = abs(fftshift(u_ave)) / max(max(max(abs(u_ave))));
[M, I] = max(u_ave(:));

% find the center frequency's location
kx_c = Kx(I);
ky_c = Ky(I);
kz_c = Kz(I);


% for j=1:49
%     Un(:,:,:)=reshape(subdata(:,j),n,n,n);
%     M = max(abs(Un),[],'all');
%     close all, isosurface(X,Y,Z,abs(Un)/M,0.7)
%     axis([-20 20 -20 20 -20 20]), grid on, drawnow
%     pause(1)
% end


% PART 2: Filter/Denoise the data. ----------------------------------------

% Define the filter
tau = 0.2;
filter = exp(-tau*((Kx - kx_c).^2 + (Ky - ky_c).^2 + (Kz - kz_c).^2));

position = zeros(n, 3);

path_x = zeros(49, 1);
path_y = zeros(49, 1);
path_z = zeros(49, 1);


for i = 1:49
    Un(:,:,:)=reshape(subdata(:,i), n, n, n);
    unft = ifftshift(filter.*fftshift((fftn(Un))));
    pos = ifftn(unft);
    pos = pos / max(max(max(pos)));
    [M, I] = max(pos(:));
    path_x(i, 1) = X(I);
    path_y(i, 1) = Y(I);
    path_z(i, 1) = Z(I);
    
    % help plot the position of submarine at each time step
%     isosurface(X, Y, Z, abs(pos), 0.4)
%     axis([-20 20 -20 20 -20 20]), grid on, drawnow
%     hold on;
end


% Find the last location of the submarine
end_pos = [path_x(49), path_y(49), path_z(49)];

close all;

% Plot the path of the submarine over the whole time period
plot3(path_x, path_y, path_z);
xlabel('x');
ylabel('y');
zlabel('z');
title('The Path of the Submarine');
grid on









