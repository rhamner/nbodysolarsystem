clear all
close all

npoints=36500; %total time is ~100 years
dt = 1/365; %time step is 1 day
xo = zeros(length(npoints), 4);
yo = xo;

%initial conditions (1 = sun, 2 = earth, 3 = jupiter, 4 = mars)
m(1) = 2E30;
m(2) = 6E24;
m(3) = m(1)/1000;
m(4) = 6E23;
x(1) = 0;
y(1) = 0;
vx(1) = 0;
vy(1) = 0;
x(2) = 1;
y(2) = 0;
vx(2) = 0;
vy(2) = 2*pi;
x(3) = 5.2;
y(3) = 0;
vx(3) = 0;
vy(3) = 2.7549;
x(4) = 1.523;
y(4) = 0;
vx(4) = 0;
vy(4) = 2*pi*1.523/1.880;
first = true;
for i = 1:npoints-1; % loop over the timesteps
    
    %calculate forces on all pairs and update velocities (defer position
    %update  until end)
    for j = 1:4
        for k = j:4
            if(k ~= j)
                dx = x(k) - x(j);
                dy = y(k) - y(j);
                D = dx*dx + dy*dy;
                Fx = -(4*pi*pi/D)*(dx/sqrt(D));
                Fy = -(4*pi*pi/D)*(dy/sqrt(D));
                
                vx(k) = vx(k) + Fx*dt*m(j)/m(1);
                vy(k) = vy(k) + Fy*dt*m(j)/m(1);
                vx(j) = vx(j) - Fx*dt*m(k)/m(1);
                vy(j) = vy(j) - Fy*dt*m(k)/m(1);
                
            end
        end
    end
    
    %update all positions
    for j = 1:4
        x(j) = x(j) + vx(j)*dt;
        y(j) = y(j) + vy(j)*dt;
    end
    
    %define coordinate system with sun at 0,0
    x = x - x(1);
    y = y - y(1);
    
    %plot periodically
    if(mod(i, 73) == 0)
        fig = figure(1)
        set(fig, 'color', [0 0 0])
        scatter(x(1), y(1), 75, [.95 .55 .25], 'filled')
        hold on
        scatter(x(2), y(2), 50, [.55 .55 .95], 'filled')
        hold on
        scatter(x(3), y(3), 60, [.95 .25 .25], 'filled')
        scatter(x(4), y(4), 40, [.55 0 0], 'filled')
        title('Actual; Mjupiter = Msun/1000', 'color', [0.95 0.95 0.95], 'fontsize', 18)
        hold off
        xlim([-6 6])
        ylim([-6 6])
        axis off
        box off
        drawnow
        frame = getframe(fig);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        if first;
          imwrite(imind,cm,'C:\temp\actual.gif','gif','DelayTime',.05, 'Loopcount',inf);
          first = false;
        else
          imwrite(imind,cm,'C:\temp\actual.gif','gif','DelayTime',.05,'WriteMode','append');
        end
    end
    xo(i, :) = x;
    yo(i, :) = y;
end

%plot total
fig = figure(2)
set(fig, 'color', [0 0 0])
scatter(xo(:, 1), yo(:, 1), 75, [.95 .55 .25], 'filled')
hold on
scatter(xo(:, 2), yo(:, 2), 50, [.55 .55 .95], 'filled')
scatter(xo(:, 3), yo(:, 3), 60, [.95 .25 .25], 'filled')
scatter(xo(:, 4), yo(:, 4), 40, [.55 0 0], 'filled')
box off
set(gca, 'XColor', [0.95 0.95 0.95], 'YColor', [0.95 0.95 0.95], 'Color', [0 0 0], 'FontSize', 16)
ylabel('AU')
xlabel('AU')
title('Actual; Mjupiter = Msun/1000', 'color', [0.95 0.95 0.95], 'fontsize', 18)