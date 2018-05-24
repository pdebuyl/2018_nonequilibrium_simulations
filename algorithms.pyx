import numpy as np
cimport numpy as np
cimport cython
from libc.stdlib cimport rand, RAND_MAX
from libc.stdlib cimport malloc, free
from libc.math cimport sqrt, cos, sin

cdef extern from "randomkit.h":
    ctypedef enum rk_error:
        pass

    ctypedef struct rk_state:
        unsigned long key[624]
        int pos
        int has_gauss
        double gauss
        int has_binomial
        double psave
        long nsave
        double r
        double q
        double fm
        long m
        double p1
        double xm
        double xl
        double xr
        double c
        double laml
        double lamr
        double p2
        double p3
        double p4

    # 0xFFFFFFFFUL
    cdef unsigned long RK_MAX
    cdef unsigned long rk_interval(unsigned long max, rk_state *state)
    cdef rk_error rk_randomseed(rk_state *state)
    cdef double rk_double(rk_state *state)
    cdef double rk_gauss(rk_state *state);

cdef rk_state *s = <rk_state *> malloc(sizeof(rk_state))
cdef rk_error local_error
local_error = rk_randomseed(s)

cdef class cyfunc_nd:
    cpdef void force(self, double[::1] x, double[::1] f):
        cdef int i
        for i in range(f.shape[0]):
            f[i] = 0
    def __init__(self):
        pass

cdef class pyfunc_nd(cyfunc_nd):
    cpdef void force(self, double[::1] x, double[::1] f):
        self.py_force(x, f)
    def __init__(self, force):
        self.py_force = force

def integrate(double[::1] x, double[::1] mu, double T, double dt, int npoints, int nsteps, f=None):
    cdef cyfunc_nd py_f
    cdef int i
    cdef double time

    if f is None:
        py_f = cyfunc_nd()
    elif isinstance(f, cyfunc_nd):
        py_f = f
    elif callable(f):
        py_f = pyfunc_nd(f)
    else:
        raise ValueError("f should be a callable or a cyfunc_d_d")

    cdef double[:,::1] x_out = np.empty(shape=(npoints, x.shape[0]), dtype=float)
    cdef double[::1] force = np.empty(x.shape[0], dtype=float)
    cdef double[::1] noise_factor = np.sqrt(2*T*dt)*np.sqrt(mu)

    for i in range(npoints):
        for j in range(nsteps):
            py_f.force(x, force)
            for k in range(x.shape[0]):
                x[k] = x[k] + force[k]*mu[k]*dt + noise_factor[k]*rk_gauss(s)
        x_out[i,:] = x

    return np.asarray(x_out)
