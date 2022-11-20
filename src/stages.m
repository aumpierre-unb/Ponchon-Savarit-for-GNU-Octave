# Copyright (C) 2022 Alexandre Umpierre
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

function [N]=stages(data,X,q,R,fig=true)
    # Syntax:
    #
    # [N]=stages(data,X,q,R[,fig=true])
    #
    # stages computes the number of theoretical stages
    #  of a distillation column
    #  using the Ponchon-Savarit method given
    #  a x-h-y-H matrix of the liquid and the vapor fractions
    #  at equilibrium and their enthalpies,
    #  the vector of the fractions of the products and the feed,
    #  the feed quality, and
    #  the reflux ratio at the top of the column.
    # If feed is a saturated liquid, feed quality q = 1,
    #  feed quality is reset to q = 1 - 1e-10.
    # By default, stages plots a schematic diagram of the solution, fig = true.
    # If fig = false is given, no plot is shown.
    # stages is a main function of
    #  the ponchon-savarit toolbox for GNU Octave.
    #
    # Examples:
    #
    # # Compute the number of theoretical stages
    # # of a distillation column for oxygen and nitrogen
    # # from the bottom to the top of the column given
    # # a matrix that relates the liquid and the vapor fractions
    # # and their enthalpies at equilibrium,
    # # the composition of the distillate is 88 %,
    # # the composition of the feed is 46 %,
    # # the composition of the column's bottom product is 11 %,
    # # the feed quality is 54 %, and
    # # the reflux ratio at the top of the column is
    # # 70 % higher that the minimum reflux ratio:
    # data=[0.    0.420 0.    1.840; # enthalpy in kcal/mmol
    #       0.075 0.418 0.193 1.755;
    #       0.17  0.415 0.359 1.685;
    #       0.275 0.410 0.50  1.625;
    #       0.39  0.398 0.63  1.570;
    #       0.525 0.378 0.75  1.515;
    #       0.685 0.349 0.86  1.465;
    #       0.88  0.300 0.955 1.425;
    #       1.    0.263 1.    1.405];
    # x=[0.88 0.46 0.11];
    # q=0.54;
    # r=refmin(data,x,q);
    # R=1.70*r;
    # N=stages(data,x,q,R)
    #
    # # Compute the number of theoretical stages
    # # of a distillation column for acetone and methanol
    # # from the bottom to the top of the column given
    # # a matrix that relates the liquid and the vapor fractions
    # # and their enthalpies at equilibrium,
    # # the composition of the distillate is 88 %,
    # # the composition of the feed is 46 %,
    # # the composition of the column's bottom product is 11 %,
    # # the feed is a saturated liquid, and
    # # the reflux ratio at the top of the column is
    # # 70 % higher that the minimum reflux ratio:
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
    # x=[0.88 0.46 0.11];
    # q=1;
    # r=refmin(data,x,q);
    # R=1.70*r;
    # N=stages(data,x,q,R)
    #
    # See also: refmin, qR2S.
    xD=X(1);
    xF=X(2);
    xB=X(3);
    if xD<xF || xB>xF
        error("Inconsistent feed and/or products compositions.");
    end
    if q==1
        q=1-1e-10;
    end
    if R<=refmin(data,X,q)
        error("Minimum reflux ratio exceeded.");
    end
    f=@(x) interp1(data(:,3),data(:,1),x);
    g=@(x) interp1(data(:,1),data(:,2),x);
    k=@(x) interp1(data(:,3),data(:,4),x);

    foo=@(x) q/(q-1)*x-xF/(q-1);
    bar=@(x) interp1(data(:,1),data(:,3),x)-foo(x);
    x1=bissection(bar,xB,xD);
    h1=g(x1);
    y1=interp1(data(:,1),data(:,3),x1);
    H1=k(y1);
    hF=(H1-h1)*(1-q)+h1;

    hliq=g(xD);
    Hvap=k(xD);
    hdelta=(Hvap-hliq)*R+Hvap;

    hlambda=(hdelta-hF)/(xD-xF)*(xB-xF)+hF;

    x2=myinterp(g,[xD hdelta],[xB hlambda],min(data(:,1)),max(data(:,1)));

    y=[xD];
    x=[f(y(end))];
    while x(end)>xB
        if x(end)>x2
            P=[xD;hdelta];
        else
            P=[xB;hlambda];
        end
        Q=[x(end);g(x(end))];
        y=[y;myinterp(k,P,Q,min(data(:,3)),max(data(:,3)))];
        x=[x;f(y(end))];
    end

    x=[xD;x];
    y=[y;x(end)];

    h=g(x);
    H=k(y);

    N=size(x,1)-1-1+(xB-x(end-1))/(x(end)-x(end-1));

    if fig
        figure('position',[100 100 500 800]);
        subplot(2,1,1)
        plot(data(:,1),data(:,2),'-bd','linewidth',1.25);
        hold on;plot(data(:,3),data(:,4),'-rd','linewidth',1.25);
        hold on, plot(reshape([x y]'(1:end-1),2*size(x,1)-1,1),...
                      reshape([h H]'(1:end-1),2*size(x,1)-1,1),'-c');
        hold on;plot([xD xD xD xF xB xB xB],...
                     [g(xD) k(xD) hdelta hF hlambda g(xB) k(xB)],'-go');
        hold on;plot(sort([x1 xF y1]),sort([h1 hF H1]),'-.*m');
        xlabel('{\itx},{\ity}');
        ylabel('{\ith},{\itH}');
        grid on;
        set(gca,'fontsize',16,'box','on');
        subplot(2,1,2);
        hold on;plot([xF xF],[0 1],'--m');
        hold on;plot([xD xD],[0 1],'--b');
        hold on;plot([xB xB],[0 1],'--r');
        plot(data(:,1),data(:,3),'-ok','linewidth',1.25);
        hold on;plot([0 1],[0 1],'--k');
        hold on;stairs(x,y,'c');
        hold on,plot(x,y,'-gd');
        hold on;plot([0 1],[foo(0) foo(1)],'-.m')
        axis([0 1 0 1]);
        xlabel('{\itx}');
        ylabel('{\ity}');
        grid on;
        set(gca,'fontsize',16,'box','on');
    end
end

