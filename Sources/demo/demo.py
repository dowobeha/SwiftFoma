#!/usr/bin/python3

from ctypes import *
from ctypes.util import find_library

fomalibpath = find_library('foma')
foma = cdll.LoadLibrary(fomalibpath)

filename="demo.bin"

fst_handle = foma.fsm_read_binary_file(c_char_p(filename.encode('utf8')))
fst_applicator = foma.apply_init(fst_handle)


cat = c_char_p("cat".encode('utf8'))
foma.apply_down.restype = c_char_p
dog = foma.apply_down(c_void_p(fst_applicator), cat)
print(type(dog))
print(dog.decode('UTF-8'))
