% 
%
% Compute isovolumic pressure using ventricle model
% adapted from the book Introduction to biomedical engineering JD Enderle JD Bronzino
% Chapt. 4 Biomechanics (4.7 Cardiovascular Dynamics) pp 203 Example Problem 4.15
%
% Initial conditions:
%
clc
clear all
delt = 0.001; % The iteration time step delta t
a = 7e-4;
b = 20.;
c = 2.5;
d = 80.;
tc = 0.264;
tp = 0.371;
tr = 0.299;
tb = 0.258;
alpha = 2.88;
Initial_Vv0 = [120 180]     %% Initial (end-diastolic) ventricular volume

pv = zeros(2, 1000)
for i=1:2
    Vv0 = Initial_Vv0(1,i)  %% Initial (end-diastolic) ventricular volume
    %
    % Compute intermediate term denominator
    % to simplify computations:
    %
    denom = ((1.-exp(-(tp/tc)^alpha))*exp(-((tp-tb)/tr)^alpha));
    %
    % Compute for initial time t=0 (MATLAB does not allow 0 index)
    %
    t(1) = 0.;
    Vv(1) = Vv0;
    edp = a*((Vv0 -b))^2;
    pdp = c*Vv0 - d;
    pp = pdp/denom;
    t1 = 0.; % Time step for first exponential
    t2 = 0.; % Time step for second exponential
    e1 = exp(-(t1/tc)^alpha);
    e2 = exp(-(t2/tr)^alpha);
    pv0 = edp+pp*((1.-e1)*e2);
    %
    % Main computation loop:
    %
    for j = 2:1000
        t(j) = t(j-1)+delt;
        Vv(j) = Vv(j-1);
        %
        edp = a*((Vv(j) -b))^2;
        pdp = c*Vv(j) - d;
        pp = pdp/denom;
        t1 = t(j);
        % Second exponential begins at t > tb
        t2 = t(j) - tb;
        if (t2 < 0.) ;
            t2 = 0.;
        end
        e1 = exp(-(t1/tc)^alpha);
        e2 = exp(-(t2/tr)^alpha);
        pv(i,j) = edp+pp*((1.-e1)*e2);
    end
    %%create also a legend for each graph
    lgnd{i} = sprintf("Vv0= %3.1f\n", Initial_Vv0(1,i))

end

hold on

%% Use red and black colors for the plots
plot(t,pv(1,:),' r', 'linewidth', 2.5)
plot(t,pv(2,:),' k', 'linewidth', 2.5)

%grid on
title('Isovolumic Ventricular Pressure')
xlabel('Time [s]')
ylabel('Ventricular Pressure Pv [mmHg]')

%% add a legend for each graph in the plot
legend (lgnd{1}, lgnd{2},"location", "northeast");                
set (legend, "fontsize", 12);
hold off
