
cdef class cyfunc_nd:
    cpdef void force(self, double[::1] x, double[::1] f)

cdef class pyfunc_nd(cyfunc_nd):
    cdef object py_force
    cpdef void force(self, double[::1] x, double[::1] f)
