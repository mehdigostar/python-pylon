#!/usr/bin/env cython

#---- licence header
###############################################################################
## file :               streamGRabber.pyx
##
## description :        This file has been made to provide a python access to
##                      the Pylon SDK from python.
##
## project :            TANGO
##
## author(s) :          S.Blanch-Torn\'e
##
## Copyright (C) :      2015
##                      CELLS / ALBA Synchrotron,
##                      08290 Bellaterra,
##                      Spain
##
## This file is part of Tango.
##
## Tango is free software: you can redistribute it and/or modify
## it under the terms of the GNU Lesser General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## Tango is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU Lesser General Public License for more details.
##
## You should have received a copy of the GNU Lesser General Public License
## along with Tango.  If not, see <http:##www.gnu.org/licenses/>.
##
###############################################################################

include "Result.pyx"
include "WaitObject.pyx"

from libcpp cimport bool

cdef extern from "pylon/StreamGrabber.h" namespace "Pylon":
    ctypedef void* StreamBufferHandle
    cdef cppclass IStreamGrabber:
        void Open() except +
        void Close()
        bool IsOpen()
        StreamBufferHandle RegisterBuffer( void* Buffer, size_t BufferSize )
        void* DeregisterBuffer( StreamBufferHandle )
        void PrepareGrab()
        void FinishGrab()
        void QueueBuffer( StreamBufferHandle, const void* Context=NULL )
        void CancelGrab()
        bool RetrieveResult( GrabResult& )
        WaitObject& GetWaitObject()
        INodeMap* GetNodeMap()