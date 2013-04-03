#!/usr/bin/env julia
#GSL Julia wrapper
#(c) 2013 Jiahao Chen <jiahao@mit.edu>
#########################################
# 10.6 Reading and writing combinations #
#########################################
#############
# Footnotes #
#############
export combination_fwrite, combination_fread, combination_fprintf,
       combination_fscanf


# This function writes the elements of the combination c to the stream stream
# in binary format.  The function returns GSL_EFAILED if there was a problem
# writing to the file.  Since the data is written in the native binary format
# it may not be portable between different architectures.
# 
#   Returns: Cint
function combination_fwrite(stream::Ptr{Void}, c::Ptr{gsl_combination})
    errno = ccall( (:gsl_combination_fwrite, :libgsl), Cint, (Ptr{Void},
        Ptr{gsl_combination}), stream, c )
    if errno!= 0 throw(GSL_ERROR(errno)) end
end


# This function reads elements from the open stream stream into the combination
# c in binary format.  The combination c must be preallocated with correct
# values of n and k since the function uses the size of c to determine how many
# bytes to read.  The function returns GSL_EFAILED if there was a problem
# reading from the file.  The data is assumed to have been written in the
# native binary format on the same architecture.
# 
#   Returns: Cint
function combination_fread(stream::Ptr{Void})
    c = convert(Ptr{gsl_combination}, Array(gsl_combination, 1))
    errno = ccall( (:gsl_combination_fread, :libgsl), Cint, (Ptr{Void},
        Ptr{gsl_combination}), stream, c )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_ref(c)[1]
end


# This function writes the elements of the combination c line-by-line to the
# stream stream using the format specifier format, which should be suitable for
# a type of size_t.  In ISO C99 the type modifier z represents size_t, so
# "%zu\n" is a suitable format.1  The function returns GSL_EFAILED if there was
# a problem writing to the file.
# 
#   Returns: Cint
function combination_fprintf(stream::Ptr{Void}, c::Ptr{gsl_combination})
    format = convert(Ptr{Cchar}, Array(Cchar, 1))
    errno = ccall( (:gsl_combination_fprintf, :libgsl), Cint, (Ptr{Void},
        Ptr{gsl_combination}, Ptr{Cchar}), stream, c, format )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_ref(format)[1]
end


# This function reads formatted data from the stream stream into the
# combination c.  The combination c must be preallocated with correct values of
# n and k since the function uses the size of c to determine how many numbers
# to read.  The function returns GSL_EFAILED if there was a problem reading
# from the file.
# 
#   Returns: Cint
function combination_fscanf(stream::Ptr{Void})
    c = convert(Ptr{gsl_combination}, Array(gsl_combination, 1))
    errno = ccall( (:gsl_combination_fscanf, :libgsl), Cint, (Ptr{Void},
        Ptr{gsl_combination}), stream, c )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_ref(c)[1]
end
