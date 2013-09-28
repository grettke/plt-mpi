#lang scheme

(require scheme/foreign) (unsafe!)

(define libmpi (ffi-lib "libmpi"))

(define-struct result (value status))

; http://www.mcs.anl.gov/research/projects/mpi/www/www3/MPI_Init.html
; int MPI_Init(int *argc, char ***argv)

(define mpi-init
  (get-ffi-obj
   "MPI_Init" libmpi
   (_fun (args)
         ::
         [argc : (_ptr io _int) = (length args)]
         [argv : (_ptr i (_list io _string argc)) = args]
         ->
         _int)))

; http://www.mcs.anl.gov/research/projects/mpi/www/www3/MPI_Comm_size.html
; int MPI_Comm_size ( MPI_Comm comm, int *size )

(define mpi_comm_world
  (get-ffi-obj
   "ompi_mpi_comm_world" libmpi _fpointer))
(define mpi-comm-size
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

(define mpi-comm-rank
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

; http://www.mcs.anl.gov/research/projects/mpi/www/www3/MPI_Finalize.html
; int MPI_Finalize()

(define mpi-finalize
  (get-ffi-obj
   "MPI_Finalize" libmpi
   (_fun -> _int)))

(let ([init-args '()])
  (printf "Calling mpi-init with args: ~a~n" init-args)
  (let ([status (mpi-init init-args)])
  (printf "Called mpi-init: status was '~a'~n" status)))

(printf "Calling mpi-comm-size~n")
(let* ([result (mpi-comm-size mpi_comm_world)]
       [size (result-value result)]
       [status (result-status result)])
  (printf "Called mpi-comm-size: size was '~a' and status was '~a'~n" size status))

(printf "Calling mpi-comm-rank~n")
(let* ([result (mpi-comm-rank mpi_comm_world)]
       [rank (result-value result)]
       [status (result-status result)])
  (printf "Called mpi-comm-rank: rank was '~a' and status was '~a'~n" rank status))

(printf "Calling mpi-finalize~n")
(let ([status (mpi-finalize)])
  (printf "Called mpi-finalize: status was '~a'~n" status))