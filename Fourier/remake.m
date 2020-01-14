function signal = remake(complexes,N)
    signal = zeros(1,N);
    for time = 1:N
        for freq = 1:length(complexes)
            signal(time) = signal(time) + complexes(freq).*exp(1i*2*pi*(freq./length(complexes)).*time);
        end
    end
    
    signal = real(signal);
end