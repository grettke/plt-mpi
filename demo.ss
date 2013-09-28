#lang scheme

(require (prefix-in mpi: "mpi.ss"))

(define msg-count 5)

(define initialized? (mpi:init))

(define comm-size-result (mpi:comm-size))
(define numprocs (mpi:result-value comm-size-result))

(define comm-rank-result (mpi:comm-rank))
(define rank (mpi:result-value comm-rank-result))

(define processor_name (mpi:get-processor-name))

(printf "Process ~a on ~a out of ~a~n" rank processor_name numprocs)

(when (= rank 0) 
	(printf "sdbg: calling sendInts~n")
	(mpi:sendInts 1 0))

(when (= rank 1) 
	(printf "sdbg: calling recvInts~n")
	(mpi:recvInts 0 0))

(define finalized? (mpi:finalize))
