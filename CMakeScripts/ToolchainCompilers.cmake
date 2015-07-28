# In this file the (possibly) set compiler mnemonics are used to specify default compilers.
if (TOOLCHAIN)
    message(STATUS "Trying to use ${TOOLCHAIN} compilers..")
    STRING(TOLOWER "${TOOLCHAIN}" TOOLCHAIN)
    if (TOOLCHAIN STREQUAL "gnu" OR TOOLCHAIN STREQUAL "mingw")
        SET(CMAKE_C_COMPILER gcc)
        SET(CMAKE_CXX_COMPILER g++)
        SET(CMAKE_Fortran_COMPILER gfortran)
        
    elseif (TOOLCHAIN STREQUAL "intel")
        SET(CMAKE_C_COMPILER icc)
        SET(CMAKE_CXX_COMPILER icpc)
        SET(CMAKE_Fortran_COMPILER ifort)
        
    elseif(TOOLCHAIN STREQUAL "ibm")
        if (OCM_USE_MT)
            SET(CMAKE_C_COMPILER xlc_r)
            SET(CMAKE_CXX_COMPILER xlC_r)
            # F77=xlf77_r
            SET(CMAKE_Fortran_COMPILER xlf95_r)
        else()
            SET(CMAKE_C_COMPILER xlc)
            SET(CMAKE_CXX_COMPILER xlC)
            # F77=xlf77
            SET(CMAKE_Fortran_COMPILER xlf95)
        endif()
    else()
        message(WARNING "Unknown toolchain: ${TOOLCHAIN}. Proceeding with CMake default compilers.")
    endif()
endif()