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
	(mpi:printSimpleInts '(6 7 8 9 10))
	(mpi:sendInts '(5 4 3 2 99) 1 0 mpi:COMM/WORLD))

(when (= rank 1) 
	(printf "sdbg: calling recvInts~n")
	(mpi:recvInts 0 0 mpi:COMM/WORLD))

(define finalized? (mpi:finalize))
