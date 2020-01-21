%% Make Rose
%   This function makes a design

points = zeros;

for count = 0:4
    points(count+1) = count;
end

for count = 1:10
    points(count+5) = count*.1 + 4 + count*1i;
end

for count = 1:5
    points(count+15) = (count/5)^2*1i - 0.6*count + points(15);
end

for count = 1:5
    points(count+20) = -((5-count)*2/5)^2*1i + 0.2*count + points(20)+ 5i;
end

for count = 1:6
    points(25+count) = points(25) - 0.5*count + count*0.2i;
end

for count = 1:length(points)-2
    points(31+count) = imag(points(30-count))*1i - real(points(30-count));
end

points = (points - mean(points))/3;
%points.';
plot(real(points),imag(points));
writematrix(points.', 'vase.txt');