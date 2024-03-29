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

function x=myinterp(f,P,Q,a,b)
    # Syntax:
    # -- x=myinterp(f,P,Q,a,b)
    #
    # myinterp computes the intecection of
    #  a function and a stright line defined by two points,
    #  using bisection method given
    #  it is between the guess values.
    # myinterp is an auxiliary function of
    #  the ponchon-savarit toolbox for GNU Octave.
    g=@(x) (Q(2)-P(2))/(Q(1)-P(1))*(x-P(1))+P(2);
    h=@(x) f(x)-g(x);
    x=bisection(h,a,b);
end
