% === Step 1: Load velocity data ===
data = load('active_nematic_velocity_700.dat');
x = data(:,1) + 1;  % MATLAB indexing
y = data(:,2) + 1;
ux = data(:,4);
uy = data(:,5);

N = 51;
U = zeros(N,N); 
V = zeros(N,N);
for k = 1:length(x)
    U(y(k), x(k)) = ux(k);
    V(y(k), x(k)) = uy(k);
end

[X, Y] = meshgrid(1:N, 1:N);

% === Step 2: Compute Q field (your definition) ===
[dux_dx, dux_dy] = gradient(U);
[duy_dx, ~] = gradient(V);
Q = dux_dx.^2 + duy_dx .* dux_dy;

% === Step 3: Detect disclination cores using angle winding ===
angle_diff = @(a1, a2) atan2(sin(a2 - a1), cos(a2 - a1));
plus_half = [];
minus_half = [];

for i = 2:N-1
    for j = 2:N-1
        theta = [
            atan2(V(j,i),   U(j,i))
            atan2(V(j,i+1), U(j,i+1))
            atan2(V(j+1,i+1), U(j+1,i+1))
            atan2(V(j+1,i), U(j+1,i))
        ];
        net_rot = 0;
        for k = 1:4
            net_rot = net_rot + angle_diff(theta(k), theta(mod(k,4)+1));
        end
        if abs(net_rot) > pi
            if net_rot > 0
                plus_half = [plus_half; i, j];
            else
                minus_half = [minus_half; i, j];
            end
        end
    end
end

% === Step 4: Plot streamlines and disclinations ===
% === Step 4: Plot streamlines and disclinations ===
figure; hold on;

% Plot streamlines (light gray)
h_stream = streamslice(X, Y, U, V, 2);
set(h_stream, 'Color', [0.6 0.6 0.6]);

% Plot disclinations
h_plus  = plot(plus_half(:,1), plus_half(:,2), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 6);
h_minus = plot(minus_half(:,1), minus_half(:,2), 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 6);

xlabel('x'); ylabel('y');
axis equal tight;
title('Streamlines and Disclinations at t = 1000');

% === Improved Legend with symbols ===
h1 = plot(NaN, NaN, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 6);   % dummy +1/2
h2 = plot(NaN, NaN, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 6);   % dummy -1/2
h3 = plot(NaN, NaN, '-', 'Color', [0.6 0.6 0.6]);                      % dummy streamline

legend([h3, h1, h2], {'Streamlines', '+1/2 disclination', '−1/2 disclination'}, ...
       'Location', 'northeastoutside');
