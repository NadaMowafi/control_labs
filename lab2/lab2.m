J = 600000 ;
B = 20000 ;
K = 1 ;
numerator = K ; 
denominator = [J B K] ;
trans_func = tf(numerator , denominator) ;
state_space = ss(trans_func) 
%% c
J = 600000; 
B = 20000;  
numerator = 1;               % K = 1 
denominator = [J B numerator]; 
trans_func = tf(numerator, denominator);

% Plot root locus
figure;
rlocus(trans_func); 
title('Root Locus of the System');
xlabel('Real Axis');
ylabel('Imaginary Axis');
grid on;

% Display a message
disp('The root locus shows the stability of the system for varying K.');
disp('If all poles remain in the left-half plane for all K > 0, the system is stable.');
%% d
J = 600000;   
B = 20000;    

% Required damping ratio for M_p < 10%
zeta_min = 0.591;

% Maximum value of K for M_p < 10%
K_max = (B^2) / (4 * J * zeta_min^2);

% Display the result
disp(['Maximum value of K for M_p < 10%: ', num2str(K_max)]);
%% e
j = 600000; 
b = 20000; 
RiseTime_max = 80; 
for k = 1:1000 
    trans=tf(k,[j b k]); 
    state_space=ss(trans); 
    info=stepinfo(state_space); 
    if info.RiseTime < RiseTime_max 
        break; 
    end 
end 
% Display the max of K  
disp(['Maximum value of K for Rise Time < 80 sec:',num2str(k)]); 
%% f , g , h
K = [200, 400, 1000, 2000];
J = 600000;  
B = 20000;   
for i = 1:4
    sys_tf = tf(K(i), [J, B, K(i)]);
    figure;
    step(sys_tf);
    title(sprintf('Step response for K = %i', K(i)));
    [stepresponse, time] = step(sys_tf);
    stat = ss(sys_tf);
    
    % (Rise time and Overshoot)
    info = stepinfo(stat, 'RiseTimeThreshold', [0 1]);
    Overshoot = info.Overshoot;
    Risetime = info.RiseTime;
    fprintf('Overshoot for K = %i is: %f%%\n', K(i), Overshoot);
    fprintf('Risetime for K = %i is: %f seconds\n', K(i), Risetime);
   
    % steady-state error
    sterror = abs(1 - stepresponse(end));
    fprintf('Steady state error for K = %i is: %f\n', K(i), sterror);
    
    % Pole-Zero plot
    figure;
    h = pzplot(sys_tf);
    title(sprintf('Poles and Zeros for K = %i', K(i)));
    grid on;
end

