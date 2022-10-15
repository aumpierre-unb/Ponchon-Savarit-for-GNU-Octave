# Copyright (C) 2022 Alexandre Umpierre
#
# This file is part of ponchon-savarit toolbox.
# ponchon-savarit toolbox is free software:
# you can redistribute it and/or modify it under the terms
# of the GNU General Public License (GPL) version 3
# as published by the Free Software Foundation.
#
# ponchon-savarit toolbox is distributed in the hope
# that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the
# GNU General Public License along with this program
# (license GNU GPLv3.txt).
# It is also available at https://www.gnu.org/licenses/.

function y=myinterp(f,P,Q,a=0,b=1)
    g=@(x) (Q(2)-P(2))/(Q(1)-P(1))*(x-P(1))+P(2);
    h=@(x) f(x)-g(x);
    y=bissection(h,a,b);
end
