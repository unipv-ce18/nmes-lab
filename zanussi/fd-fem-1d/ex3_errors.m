figure(1);

ph = waitbar(0);
for k = 0:3
   eps = 10.^-k;

   waitbar(k/4, ph, sprintf('Running for epsilon = %.3f', eps));
   subplot(2,2,k+1);
   title(sprintf("eps = %.3f", eps));
   ex3;
end
close(ph);
