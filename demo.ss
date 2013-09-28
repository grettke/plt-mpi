#lang scheme

(require (prefix-in mpi: "mpi.ss"))

(define initialized? (mpi:init))

(define comm-size-result (mpi:comm-size))
(define numprocs (mpi:result-value comm-size-result))

(define comm-rank-result (mpi:comm-rank))
(define rank (mpi:result-value comm-rank-result))

(define processor_name (mpi:get-processor-name))

(printf "Process ~a on ~a out of ~a~n" rank processor_name numprocs)

(define finalized? (mpi:finalize))