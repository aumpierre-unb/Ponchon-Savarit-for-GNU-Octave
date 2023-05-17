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

function x2=bissection(f,x1,x2)
    # Syntax:
    # -- x2=bissection(f,x1,x2)
    #
    # bissection computes the root of
    #  a function using the method of bissection
    #  given it is found between the guess values.
    # bissection is an auxiliary function of
    #  the ponchon-savarit toolbox for GNU Octave.
    while abs(f(x2))>1e-4
        x=(x1+x2)/2;
        if f(x)*f(x1)>0
            x1=x;
        else
            x2=x;
        end
    end
end
