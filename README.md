# Langevin simulations for nonequilibrium physics

Pierre de Buyl  
Instituut voor Theoretische Fysica, KU Leuven


This repository complements the lecture notes *Langevin simulations for
nonequilibrium physics* (that will be published on the arXiv early june 2018
and will be found on the arXiv author id page
https://arxiv.org/a/debuyl_p_1.html )

## Content

- [01 - Introduction.ipynb](01%20-%20Introduction.ipynb): a short introduction to
  Python and NumPy.
- [02 - Numerical simulation of the Langevin equation.ipynb](02%20-%20Numerical%20simulation%20of%20the%20Langevin%20equation.ipynb):
  presentation of the Euler and Stochastic Runge-Kutta algorithms.
- [algorithms.pxd](algorithms.pxd) and [algorithms.pyx](algorithms.pyx): a
  Cython implementation of the algorithms. The algorithms accept Python
  functions or cythonized implementations for efficiency.

## Software requirements

The software requires:
- Python
- NumPy
- Matplotlib
- The Jupyter notebook
- Cython

Most of these components come with a "typical SciPy stack" which can be
installed, for instance, with the packages
[Anaconda](https://docs.anaconda.com/anaconda/install/) or
[Canopy](https://store.enthought.com/downloads/). If you have acces to a
SciPythonist near you, this is a good idea to ask that person.

If you have already installed Python and have a matching C compiler, the
installation can be performed by

```
python3 -m pip install --user -U pip
python3 -m pip install --user -r requirements.txt
```

## Citation

If you make use of this material in published work (whether the code or the
lecture notes), please cite the arXiv entry that will be shortly available at
https://arxiv.org/a/debuyl_p_1.html

## License

The code (the notebooks and the `algorithms` module) is distributed under the
BSD license (found in the file [](LICENSE)).

