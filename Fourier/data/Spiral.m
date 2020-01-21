%% Calming Spirals
%   This script generates a calming spiral
%close figure;

v_r = 0.05;
a_r = 0.5;
r = 0;
points1 = zeros;
points2 = zeros;
for inc = 1:360*5
    points1(inc) = r*exp(2i*pi*inc/360);
    points2(inc) = r*exp(2i*pi*inc/360 + pi/6);
    r = r+v_r;
    v_r = v_r+a_r*inc^2;
end

figure;
plot(real(points1),imag(points1), 'r', real(points2), imag(points2), 'b');

points = zeros;
for inc = 1:2*360*5
    if (rem(inc,2) == 0)
        points(inc) = points1(inc/2);
    else
        points(inc) = points2((inc+1)/2);
    end
end

figure;
plot(real(points), imag(points));
writematrix(points.'./1E11, 'spiral.txt');