%% Imaginary House
%   This file is used to draw a house in simple imaginary numbers

points = zeros;

% First verticle branch
for count = 0:30
    points(count+1) = count*1j;
end

for count = 1:10
    points(31+count) = points(31) - count;
end

for count = 1:50
    points(41+count) = points(41) + count*(3/5)*1j + count*(4/5);
end

points = points - points(91);
for count = 1:90
    points(91+count) = -real(points(91-count)) + imag(points(91-count))*1j;
end

for count = 0:60
    points(182+count) = points(181) - count;
end

points = (points - mean(points))/10;
points.';
plot(real(points),imag(points));

writematrix(points.', 'house.txt');