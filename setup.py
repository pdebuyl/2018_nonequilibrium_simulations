from setuptools import setup, Extension
from Cython.Build import cythonize
import numpy as np
import os
import imp

ran_base = os.path.join(os.path.dirname(np.__file__),'random')

_, ran_module, _ = imp.find_module('mtrand', [ran_base])

algorithms = cythonize(Extension("algorithms", sources=["algorithms.pyx"],
                       extra_objects=[ran_module],
                       include_dirs=[ran_base]))

setup(name='algorithms',
      description='Numerical simulation of the Langevin equation',
      author='Pierre de Buyl',
      license='BSD',
      ext_modules = algorithms,
)

