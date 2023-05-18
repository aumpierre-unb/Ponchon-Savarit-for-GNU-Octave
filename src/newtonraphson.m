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

function x=newtonraphson(f,x)
    # Syntax:
    # -- x=newtonraphson(f,x)
    #
    # newtonraphson computes the root of
    #  a function using the method of Newton-Raphson
    #  given a guess value.
    # newtonraphson is an auxiliary function of
    #  the ponchon-savarit toolbox for GNU Octave.
    while abs(f(x))>5e-4
        a=(f(x+1e-7)-f(x))/1e-7;
        if x-f(x)/a>1
            x=(x+1)/2;
        elseif x-f(x)/a<0
            x=x/2;
        else
            x=x-f(x)/a;
        end
    end
end