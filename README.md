`ponchon-savarit` Toolbox for GNU-Octave

<!--[![DOI](https://zenodo.org/badge/544044423.svg)](https://zenodo.org/badge/latestdoi/544044423)-->
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
<!--![GitHub release (latest by date)](https://img.shields.io/github/v/release/aumpierre-unb/Ponchon-Savarit-for-GNU-Octave)-->

<!--![Illustrative graphical output](https://github.com/aumpierre-unb/Ponchon-Savarit-for-GNU-Octave/blob/main/pics/downup_matrix.png "Example of graphical output - from x-y data set, stages from bottom to top")

![Illustrative graphical output](https://github.com/aumpierre-unb/Ponchon-Savarit-for-GNU-Octave/blob/main/pics/updown_satliq.png "Example of graphical output - from y=f(x) function and saturated liquid feed, stages from top to bottom")-->

# Installing and Loading `ponchon-savarit`

```dotnetcli
use this call to install version 0.1.0, or modify the command line for match the version
pkg install https://github.com/aumpierre-unb/Ponchon-Savarit-for-GNU-Octave/archive/refs/tags/v0.1.0.tar.gz
pkg load Ponchon-Savarit
```

# Citation of `ponchon-savarit`

You can cite all versions (both released and pre-released), by using
[DOI 10.5281/zenodo.7133683](https://doi.org/10.5281/zenodo.7211819).

This DOI represents all versions, and will always resolve to the latest one.

For citation of the last released version of `ponchon-savarit`, please check CITATION file at the [maintainer's repository](https://github.com/aumpierre-unb/Ponchon-Savarit-for-GNU-Octave).

---

The following is a very short introduction to the `ponchon-savarit` toolbox for GNU Octave.

This text is divided in two main sections: The Theory and The `ponchon-savarit` Toolbox.

# The Theory

The Ponchón-Savarit graphical method is a method to calculate the number of theoretical stages of equilibrium of a distillation column for a two component mixture. It allows for variations on the heat of vaporization, the most demanding premise of the McCabe-Thiele method. Ponchón-Savarit method demands that the column be adiabatic, except for its bottom and top, where there must heat exchange in order to maintain reflux streams.

Distillation is a unit operation based on the difference of volatility to separate different chemical species of a mixture and on gravity to separate vapor and liquid streams. There are several types of distillation.

Typically, continuous distillation is performed in a vertical column fed at its intermediate section while products at its top and bottom are recovered. As a rule of thumb, the higher the column, the higher the number of stages of equilibrium and the best is the separations of the components of the mixture fed.

## Theoretical Stage of Equilibrium

A theoretical stage of equilibrium is an abstract control volume such that the effluent currents are all in thermodynamic equilibrium. All multistage operations are based on the concept of stage of equilibrium.

## Material and Enthalpy Balances

The global and specific material balances and
the enthalpy balance for any equilibrium stage *n* are given by

$$
V_{n-1} - L_n = V_n - L_{n+1}
$$

$$
V_{n-1}\ y_{n-1} - L_n\ x_n = V_n\ y_n - L_{n+1}\ x_{n+1}
$$

$$
V_{n-1}\ H_{n-1} - L_n\ h_n = V_n\ H_n - L_{n+1}\ h_{n+1}
$$

where *L*<sub>*n*+1</sub> and *V*<sub>*n*</sub> are
the liquid and the vapor streams, *x*<sub>*n*+1</sub> and *y*<sub>*n*</sub>
are compositions of liquid and vapor streams,
and *h*<sub>*n*+1</sub> and *H*<sub>*n*</sub> are
the material enthalpy of liquid and vapor streams.

For any theoretical stage of the rectifying section,

$$
{\it\Delta} = V_n - L_{n+1}
$$

$$
{\it\Delta}\ x_{\it\Delta} = V_n\ y_n - L_{n+1}\ x_{n+1}
$$

$$
{\it\Delta}\ h_{\it\Delta} = V_n\ H_n - L_{n+1}\ h_{n+1}
$$

where ${\it\Delta}$, *x*<sub>${\it\Delta}$</sub> and *h*<sub>${\it\Delta}$</sub>
are the upcolumn stream of the rectifying section,
its global composition and its enthalpy. Combining the three balances,
one has

$$
{L_{n+1} \over V_n} = {y_n - x_\Delta \over x_{n+1} - x_\Delta} = {H_n - h_\Delta \over h_{n+1} - h_\Delta}
$$

Also, the material balances at the top of the column are

$$
D = V_n - L_{n+1}
$$

$$
D\ x_D = V_n\ y_n - L_{n+1}\ x_{n+1}
$$

where *D*, *x*<sub>*D*</sub> and *h*<sub>*D*</sub> are
the distillate stream and its composition.
It follows that ${\it\Delta}$ = *D* and *x*<sub>${\it\Delta}$</sub> = *x*<sub>*D*</sub>.

The ratio between the distillate *D* and
the refluxing current *L*<sub>*N*+1</sub> is the reflux ratio at the top of the column,

$$
R = {L_{N+1} \over D} = {L_{N+1} \over {\it\Delta}}
$$

Given the enthalpy diagram of the vapor and the liquid at equilibrium
and the composition of the distillate *x*<sub>*D*</sub> and the reflux ratio *R*
it is possible to calculate *x*<sub>${\it\Delta}$</sub>.
It is then possible to calculate *x*<sub>*n*+1</sub> from *y*<sub>*n*</sub>
and *L*<sub>*n*+1</sub> from *V*<sub>*n*</sub>
for any stage *n* of the rectifying section.

The balances of the column is given by

$$
F = {\it\Delta} + {\it\Lambda}
$$

$$
F\ x_F = {\it\Delta}\ x_{\it\Delta} + {\it\Lambda}\ x_{\it\Lambda}
$$

$$
F\ h_F = {\it\Delta}\ h_{\it\Delta} + {\it\Lambda}\ h_{\it\Lambda}
$$

where *x*<sub>*F*</sub> and *h*<sub>*F*</sub> are
the composition and the enthalpy of the feed and
${\it\Lambda}$, *x*<sub>${\it\Lambda}$</sub> and *h*<sub>${\it\Lambda}$</sub> are
the downcolumn stream of the stripping section and its composition and enthalpy.

The enthalpy of the feed *h*<sub>*F*</sub> can be calculated
from the composition *x*<sub>*F*</sub> and the quality *q* of the feed,

$$
(1 - q)\ y_n + q\ x_{n+1} = x_F
$$

$$
(1 - q)\ H_n + q\ h_{n+1} = h_F
$$

So that

$$
{{\it\Lambda} \over {\it\Delta}} = {x_{\it\Delta} - x_F \over x_F - x_{\it\Lambda}} = {h_{\it\Delta} - h_F \over h_F - h_{\it\Lambda}}
$$

Analogously to the rectifying section,
${\it\Lambda}$ = *B* and *x*<sub>${\it\Lambda}$</sub> = *x*<sub>*B*</sub>,
where *B* and *x*<sub>*B*</sub> are the column's bottom product and its composition.

# The `ponchon-savarit` Toolbox

`ponchon-savarit` provides the following functions:

- `stages`
- `refmin`
- `qR2S`

## `stages`

`stages` computes the number of theoretical stages
of a distillation column using the Ponchon-Savarit method given
a *x*-*h*-*y*-*H* matrix of the liquid and the vapor fractions
at equilibrium and their enthalpies,
the vector of the fractions of the products and the feed,
the feed quality, and the reflux ratio at the top of the column.
If feed is a saturated liquid, feed quality *q* = 1,
feed quality is reset to *q* = 1 - 1e-10.
By default, stages plots a schematic diagram of the solution, *fig* = *true*.
If *fig* = *false* is given, no plot is shown.

If feed is a saturated liquid, feed quality *q* = 1,
feed quality is reset to *q* = 1 - 1e-10.

By default, `stages` plots a schematic diagram of the solution, *fig* = *true*.

If *fig* = *false* is given, no plot is shown.

**Syntax:**

```dotnetcli
[N]=stages(y,X,q,R[,fig])
```

**Examples:**

Compute the number of theoretical stages
of a distillation column for oxygen and nitrogen
from the bottom to the top of the column given
a matrix that relates the liquid and the vapor fractions
and their enthalpies at equilibrium,
the composition of the distillate is 88 %,
the composition of the feed is 46 %,
the composition of the column's bottom product is 11 %,
the feed quality is 54 %, and
the reflux ratio at the top of the column is
70 % higher that the minimum reflux ratio:

```dotnetcli
data=[ 0.    420 0.    1840; # enthalpies in kcal/mol
       0.075 418 0.193 1755;
       0.17  415 0.359 1685;
       0.275 410 0.50  1625;
       0.39  398 0.63  1570;
       0.525 378 0.75  1515;
       0.685 349 0.86  1465;
       0.88  300 0.955 1425;
       1.    263 1.    1405];
x=[0.88 0.46 0.11];
q=0.54;
r=refmin(data,x,q);
R=1.70*r;
N=stages(data,x,q,R,false,false)
```

Compute the number of theoretical stages
of a distillation column for acetone and methanol
from the bottom to the top of the column given
a matrix that relates the liquid and the vapor fractions
and their enthalpies at equilibrium,
the composition of the distillate is 88 %,
the composition of the feed is 46 %,
the composition of the column's bottom product is 11 %,
the feed is a saturated liquid, and
the reflux ratio at the top of the column is
70 % higher that the minimum reflux ratio:

```dotnetcli
data=[2.5e-4 3.235 1.675e-3 20.720; # enthalpies in kcal/mol
      0.05   2.666 0.267    20.520;
      0.1    2.527 0.418    20.340;
      0.15   2.459 0.517    20.160;
      0.2    2.422 0.579    20.000;
      0.3    2.384 0.665    19.640;
      0.4    2.358 0.729    19.310;
      0.5    2.338 0.779    18.970;
      0.6    2.320 0.825    18.650;
      0.7    2.302 0.87     18.310;
      0.8    2.284 0.915    17.980;
      0.9    2.266 0.958    17.680;
      1.     2.250 1.       17.390];
x=[0.88 0.46 0.11];
q=1;
r=refmin(data,x,q);
R=1.70*r;
N=stages(data,x,q,R,false,false)
```

## `refmin`

`refmin` computes the minimum value of the reflux ratio
of a distillation column using the Ponchón-Savarit method given
a *x*-*h*-*y*-*H* matrix of the liquid and the vapor fractions
at equilibrium and their enthalpies,
the vector of the fractions of the products and the feed, and
the feed quality.

If feed is a saturated liquid, feed quality *q* = 1,
feed quality is reset to *q* = 1 - 1e-10.

**Syntax:**

```dotnetcli
[R]=refmin(f,X,q)
```

**Examples:**

Compute the minimum value of the reflux ratio
of a distillation column for oxygen and nitrogen given
a matrix that relates the liquid and the vapor fractions
and their enthalpies at equilibrium,
the composition of the distillate is 88 %,
the composition of the feed is 46 %,
the feed quality is 54 %:

```dotnetcli
data=[ 0.    420 0.    1840; # enthalpies in kcal/mol
       0.075 418 0.193 1755;
       0.17  415 0.359 1685;
       0.275 410 0.50  1625;
       0.39  398 0.63  1570;
       0.525 378 0.75  1515;
       0.685 349 0.86  1465;
       0.88  300 0.955 1425;
       0.1   263 1.    1405];
x=[0.88 0.46];
q=0.54;
r=refmin(data,x,q)
```

Compute the minimum value of the reflux ratio
of a distillation column for acetone and methanol given
a matrix that relates the liquid and the vapor fractions
and their enthalpies at equilibrium,
the composition of the distillate is 88 %,
the composition of the feed is 46 %,
the feed is a saturated liquid:

```dotnetcli
data=[2.5e-4 3.235 1.675e-3 20.720; # enthalpies in kcal/mol
      0.05   2.666 0.267    20.520;
      0.1    2.527 0.418    20.340;
      0.15   2.459 0.517    20.160;
      0.2    2.422 0.579    20.000;
      0.3    2.384 0.665    19.640;
      0.4    2.358 0.729    19.310;
      0.5    2.338 0.779    18.970;
      0.6    2.320 0.825    18.650;
      0.7    2.302 0.87     18.310;
      0.8    2.284 0.915    17.980;
      0.9    2.266 0.958    17.680;
      1      2.250 1        17.390];
x=[0.88 0.46 0.08];
q=1;
r=refmin(data,x,q)
```

## `qR2S`

`qR2S` computes the reflux ratio at the bottom
of a distillation column
using the Ponchon-Savarit method given
a *x*-*h*-*y*-*H* matrix of the liquid and the vapor fractions
at equilibrium and their enthalpies,
the vector of the fractions of the products and the feed,
the feed quality, and
the reflux ratio at the top of the column.

If feed is a saturated liquid, feed quality *q* = 1,
feed quality is reset to *q* = 1 - 1e-10.

**Syntax:**

```dotnetcli
[S]=qR2S(R,X,q)
```

**Examples:**

Compute the reflux ratio at the bottom
of a distillation column for oxygen and nitrogen given
the composition of the distillate is 88 %,
the composition of the feed is 46 %,
the composition of the column's bottom product is 11 %,
the feed quality is 54 %, and
the reflux ratio at the top of the column is 2.

```dotnetcli
data=[ 0.    420 0.    1840; # enthalpies in kcal/mol
       0.075 418 0.193 1755;
       0.17  415 0.359 1685;
       0.275 410 0.50  1625;
       0.39  398 0.63  1570;
       0.525 378 0.75  1515;
       0.685 349 0.86  1465;
       0.88  300 0.955 1425;
       0.1   263 1.    1405];
x=[0.88 0.46 0.11];
q=0.54;
R=2;
S=qR2S(x,q,R)
```dotnetcli

Compute the reflux ratio at the bottom
of a distillation column for acetone and methanol given
the composition of the distillate is 88 %,
the composition of the feed is 46 %,
the composition of the column's bottom product is 11 %,
the feed is saturated liquid, and
the reflux ratio at the top of the column is 2.

```dotnetcli
data=[2.5e-4 3.235 1.675e-3 20.720; # enthalpies in kcal/mol
      0.05   2.666 0.267    20.520;
      0.1    2.527 0.418    20.340;
      0.15   2.459 0.517    20.160;
      0.2    2.422 0.579    20.000;
      0.3    2.384 0.665    19.640;
      0.4    2.358 0.729    19.310;
      0.5    2.338 0.779    18.970;
      0.6    2.320 0.825    18.650;
      0.7    2.302 0.87     18.310;
      0.8    2.284 0.915    17.980;
      0.9    2.266 0.958    17.680;
      1      2.250 1        17.390];
x=[0.88 0.46 0.11];
q=1;
R=2;
S=qR2S(data,x,q,R)
```

Copyright &copy; 2022 Alexandre Umpierre

email: <aumpierre@gmail.com>
