# Copyright (C) 2022 2023 Alexandre Umpierre
#
# This file is part of ponchon-savarit toolbox for GNU Octave.
# ponchon-savarit toolbox for GNU Octave is free software:
# you can redistribute it and/or modify it under the terms
# of the GNU General Public License (GPL) version 3
# as published by the Free Software Foundation.
#
# ponchon-savarit toolbox for GNU Octave is distributed in the hope
# that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the
# GNU General Public License along with this program
# (license GNU GPLv3.txt).
# It is also available at https://www.gnu.org/licenses/.

function N=stages(data,X,q=NaN,R=NaN,S=NaN,fig=true)
    # Syntax:
    # -- N=stages(data,X,q,R,:[,fig=true])
    # -- N=stages(data,X,q,:,S[,fig=true])
    # -- N=stages(data,X,:,R,S[,fig=true])
    #
    # stages computes the number of theoretical stages
    #  of a distillation column
    #  using the Ponchón-Savarit method given
    #  a x-h-y-H matrix of the liquid and the vapor fractions
    #  at equilibrium and their enthalpies,
    #  the vector of the fractions of the products and the feed and
    #  two paramaeters aong the feed quality,
    #  the reflux ratio at the top of the column and
    #  the reflux ratio at the bottom of the column.
    # By default, fig = true, stages plots a schematic diagram of the solution.
    # If fig = false is given, no plot is shown.
    # stages is a main function of
    #  the ponchon-savarit toolbox for GNU Octave.
    #
    # Examples:
    # # Compute the number of theoretical stages
    # # of a distillation column for acetone and methanol
    # # from the bottom to the top of the column given
    # # a matrix that relates the liquid and the vapor fractions
    # # and their enthalpies at equilibrium,
    # # the composition of the distillate is 93 %,
    # # the composition of the feed is 41 %,
    # # the composition of the bottoms is 7 %,
    # # the feed is a saturated liquid and
    # # the reflux ratio at the top of the column is
    # # 55 % higher that the minimum reflux ratio,
    # # and plot a schematic diagram of the solution:
    # data=[2.5e-4 3.235 1.675e-3 20.720; # enthalpy in kcal/mol
    #       0.05   2.666 0.267    20.520;
    #       0.1    2.527 0.418    20.340;
    #       0.15   2.459 0.517    20.160;
    #       0.2    2.422 0.579    20.000;
    #       0.3    2.384 0.665    19.640;
    #       0.4    2.358 0.729    19.310;
    #       0.5    2.338 0.779    18.970;
    #       0.6    2.320 0.825    18.650;
    #       0.7    2.302 0.87     18.310;
    #       0.8    2.284 0.915    17.980;
    #       0.9    2.266 0.958    17.680;
    #       1.     2.250 1.       17.390];
    # x=[0.93;0.41;0.07];
    # [r,s]=refmin(data,x,q=1)
    # N=stages(data,x,q,R=1.55*r)
    #
    # # Compute the number of theoretical stages
    # # of a distillation column for oxygen and nitrogen
    # # from the bottom to the top of the column given
    # # a matrix that relates the liquid and the vapor fractions
    # # and their enthalpies at equilibrium,
    # # the composition of the distillate is 88 %,
    # # the composition of the feed is 44 %,
    # # the composition of the bottoms is 8 %,
    # # the feed quality is 55 % and
    # # the reflux ratio at the bottom of the column is
    # # 46 % higher that the minimum reflux ratio and
    # # plot a schematic diagram of the solution:
    # data=[0.    0.420 0.    1.840; # enthalpy in kcal/mmol
    #       0.075 0.418 0.193 1.755;
    #       0.17  0.415 0.359 1.685;
    #       0.275 0.410 0.50  1.625;
    #       0.39  0.398 0.63  1.570;
    #       0.525 0.378 0.75  1.515;
    #       0.685 0.349 0.86  1.465;
    #       0.88  0.300 0.955 1.425;
    #       1.    0.263 1.    1.405];
    # x=[0.88;0.44;0.08];
    # [r,s]=refmin(data,x,q=0.55)
    # N=stages(data,x,q,:,S=1.46*s)
    #
    # # Compute the number of theoretical stages
    # # of a distillation column for oxygen and nitrogen
    # # from the bottom to the top of the column given
    # # a matrix that relates the liquid and the vapor fractions
    # # and their enthalpies at equilibrium,
    # # the composition of the distillate is 92 %,
    # # the composition of the feed is 59 %,
    # # the composition of the bottoms is 9 %,
    # # the reflux ratio at the bottom of the column is 1.9,
    # # the reflux ratio at the top of the column is 1.5:
    # data=[0.    0.420 0.    1.840; # enthalpy in kcal/mmol
    #       0.075 0.418 0.193 1.755;
    #       0.17  0.415 0.359 1.685;
    #       0.275 0.410 0.50  1.625;
    #       0.39  0.398 0.63  1.570;
    #       0.525 0.378 0.75  1.515;
    #       0.685 0.349 0.86  1.465;
    #       0.88  0.300 0.955 1.425;
    #       1.    0.263 1.    1.405];
    # x=[0.92;0.59;0.09];
    # q=RS2q(data,x,R=1.5,S=1.9)
    # N=stages(data,x,:,R,S,fig=false)
    #
    # See also: refmin, qR2S, qS2R, RS2q.
    xD=X(1);
    xF=X(2);
    xB=X(3);
    if xD<xF || xB>xF
        error("Inconsistent feed and/or products compositions.");
    end
    a=isnan([q R S])==0;
    if sum(a)~=2
        error("psychro demands two and only two parameters.\nUnknowns must be assigned with ':'.");
    end
    if a==[1 0 1]
        R=qS2R(data,X,q,S);
    elseif a==[0 1 1]
        q=RS2q(data,X,R,S);
    end
    r=refmin(data,X,q);
    if R<=refmin(data,X,q)
        error("Minimum reflux ratio exceeded.");
    end
    x2y=@(x) interp1(data(:,1),data(:,3),x);
    y2x=@(y) interp1(data(:,3),data(:,1),y);
    x2h=@(x) interp1(data(:,1),data(:,2),x);
    y2H=@(y) interp1(data(:,3),data(:,4),y);
    foo=@(x) q-(x2y(x)-xF)/(x2y(x)-x);
    x1=bisection(foo,min(data(:,1)),max(data(:,1)));
    h1=x2h(x1);
    y1=x2y(x1);
    H1=y2H(y1);
    hF=(H1-h1)/(y1-x1)*(xF-x1)+h1;
    h2=x2h(xD);
    H2=y2H(xD);
    hdelta=(H2-h2)*R+H2;
    hlambda=(hdelta-hF)/(xD-xF)*(xB-xF)+hF;
    bar=@(x) (H1-h1)/(y1-x1)*(x-x1)+h1;
    y=[xD];
    x=[y2x(y(end))];
    while x(end)>xB
        if x(end)>x1
            P=[xD;hdelta];
        else
            P=[xB;hlambda];
        end
        Q=[x(end);x2h(x(end))];
        y=[y;myinterp(y2H,P,Q,min(data(:,3)),max(data(:,3)))];
        x=[x;y2x(y(end))];
    end
    x=[xD;x];
    y=[y;x(end)];
    h=x2h(x);
    H=y2H(y);
    N=size(x,1)-1-1+(xB-y(end-1))/(y(end)-y(end-1));
    if fig
        figure('position',[100 100 500 800]);
        subplot(2,1,1);
        hold on;
        plot(data(:,1),data(:,2),'-bd','linewidth',1.25);
        plot(data(:,3),data(:,4),'-rd','linewidth',1.25);
        plot(reshape([x y]'(1:end-1),2*size(x,1)-1,1),...
            reshape([h H]'(1:end-1),2*size(x,1)-1,1),'-c');
        plot([xD xD xD xF xB xB xB],...
            [x2h(xD) y2H(xD) hdelta hF hlambda x2h(xB) y2H(xB)],'-o','color','#1D8B20');
        plot(sort([x1 xF y1]),sort([h1 hF H1]),'-.*m');
        xlabel('{\itx},{\ity}');
        ylabel('{\ith},{\itH}');
        grid on;
        set(gca,'fontsize',14,'box','on');
        hold off;
        subplot(2,1,2);
        hold on;
        plot([xF xF],[0 1],'--m');
        plot([xD xD],[0 1],'--b');
        plot([xB xB],[0 1],'--r');
        plot(data(:,1),data(:,3),'-ok','linewidth',1.25);
        plot([0 1],[0 1],'--k');
        stairs(x,y,'c');
        plot(x,y,'-d','color','#1D8B20');
        plot([0 1],q/(q-1)*[0 1]-xF/(q-1),'-.m');
        axis([0 1 0 1]);
        xlabel('{\itx}');
        ylabel('{\ity}');
        grid on;
        set(gca,'fontsize',14,'box','on');
        hold off;
    end
end
