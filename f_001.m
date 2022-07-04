clear all,close all,clc;
%%
syms x1 x2 x3 u
%%
x1dot=(x1)^2+x2
x2dot=x3
x3dot=u
%%
y=x1;
y_dot=jacobian([y],[x1 x2 x3])*[x1dot;x2dot;x3dot]; y_dot=expand(y_dot)
y_ddot=jacobian([y_dot],[x1 x2 x3])*[x1dot;x2dot;x3dot]; y_ddot=expand(y_ddot)
y_dddot=jacobian([y_ddot],[x1 x2 x3])*[x1dot;x2dot;x3dot]; y_dddot=expand(y_dddot)

T=6*x1^4 + 8*x1^2*x2 + 2*x3*x1 + 2*x2^2;

uu=-T-2*y_ddot-2*y_dot-y



%%
fig1=figure(1);fig1.Color=[1,1,1];
ax1=axes('Parent',fig1);
    set(0,'CurrentFigure',fig1);
    set(fig1,'currentaxes',ax1);
for ii=1:1:10
tspan=[0:0.01:10]; x0=randi([-10,10],3,1)*0.1;
wt=tspan;
% f=randi([1,20],1,1); w=sin(2*pi*f*tspan);
w=square(tspan);
[t,x]=ode45(@(t,x) odefcn(t,x,wt,w),tspan,x0);
x1_vec=x(:,1);x2_vec=x(:,2);x3_vec=x(:,3);
plot(t,x1_vec,'r-','LineWidth',[2],"Parent",ax1);hold on;
plot(t,x2_vec,'g-','LineWidth',[2],"Parent",ax1);hold on;
plot(t,x3_vec,'b-','LineWidth',[2],"Parent",ax1);hold on;
hold on;yline(1);yline(-1);
end
function xdot=odefcn(t,x,wt,w)
w=interp1(wt,w,t);
xdot=zeros(3,1);
x1=x(1);x2=x(2);x3=x(3);
u=-x1-2*x2-2*x3-4*x1*x2-2*x1*x3-8*x1^2*x2-2*x1^2-4*x1^3-2*x2^2-6*x1^4;
xdot(1)=(x1^2)+x2;
xdot(2)=x3;
xdot(3)=u;
end
%