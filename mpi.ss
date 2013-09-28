#lang scheme

(require scheme/foreign) (unsafe!)

(provide (except-out (all-defined-out)
                     libmpiglue
                     libmpi
                     init-impl
                     comm-size-impl
                     comm-rank-impl))

(define libmpiglue (ffi-lib "libmpiglue"))

(define libmpi (ffi-lib "libmpi"))

(define-struct result (value status))

; http://www.mcs.anl.gov/research/projects/mpi/www/www3/MPI_Init.html
; int MPI_Init(int *argc, char ***argv)

(define (init #:args [args '()])
  (init-impl args))

(define init-impl
  (get-ffi-obj
   "MPI_Init" libmpi
   (_fun (args)
         ::
         [argc : (_ptr io _int) = (length args)]
         [argv : (_ptr i (_list io _string argc)) = args]
         ->
         _int)))

(define COMM/WORLD
  (get-ffi-obj
   "ompi_mpi_comm_world" libmpi _fpointer))

; http://www.mcs.anl.gov/research/projects/mpi/www/www3/MPI_Comm_size.html
; int MPI_Comm_size ( MPI_Comm comm, int *size )

(define (comm-size #:comm [comm COMM/WORLD])
  (comm-size-impl comm))

(define comm-size-impl
  (get-ffi-obj
   "MPI_Comm_size" libmpi
   (_fun (comm)
         ::
         [comm : _pointer]
         [size : (_ptr io _int) = -1]
         ->
         [status : _int]
         ->
         (make-result size status))))

; http://www.mcs.anl.gov/research/projects/mpi/www/www3/MPI_Comm_rank.html
; int MPI_Comm_rank ( MPI_Comm comm, int *rank )

(define (comm-rank #:comm [comm COMM/WORLD])
  (comm-rank-impl comm))

(define comm-rank-impl
  (get-ffi-obj
   "MPI_Comm_rank" libmpi
   (_fun (comm)
         ::
         [comm : _pointer]
         [rank : (_ptr io _int) = -1]
         ->
         [status : _int]
         ->
         (make-result rank status))))

; http://www.mcs.anl.gov/research/projects/mpi/www/www3/MPI_Get_processor_name.html

(define get-processor-name
  (get-ffi-obj
   "mpiglue_Get_processor_name" libmpiglue
   (_fun -> _string)))

; http://www.mcs.anl.gov/research/projects/mpi/www/www3/MPI_Finalize.html
; int MPI_Finalize()

(define finalize
  (get-ffi-obj
   "MPI_Finalize" libmpi
   (_fun -> _int)))

(define sendInts
  (get-ffi-obj
   "mpiglue_Send_ints" libmpiglue
   (_fun (args dest tag comm)
	::
	[len : _int = (length args)]
	[args : (_list io _int len)]
	[dest : _int]
	[tag : _int]
	[comm : _pointer]
	 ->
	_int)))

(define recvInts
  (get-ffi-obj
   "mpiglue_Recv_ints" libmpiglue
   (_fun (source tag comm)
	::
	[source : _int]
	[tag : _int]
	[comm : _pointer]
	->
	(_list o _int 5))))

(define getSimpleInts
  (get-ffi-obj
   "getSimpleInts" libmpiglue
   (_fun -> (_list o _int 5))))
