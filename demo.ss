#lang scheme

(require (prefix-in mpi: "mpi.ss"))

(define initialized? (mpi:init))

(define comm-size-result (mpi:comm-size))
(define numprocs (mpi:result-value comm-size-result))

(define comm-rank-result (mpi:comm-rank))
(define rank (mpi:result-value comm-rank-result))

(define processor-name (mpi:get-processor-name))

(printf "Process ~a on ~a out of ~a~n" rank processor-name numprocs)

(when (= rank 0)
      (let ((status (mpi:sendInts '(19 14 13 12 11) 1 0 mpi:COMM/WORLD)))
        (printf "[~a]Send status: ~a~n" rank status)))

(when (= rank 1)
      (let ((data (mpi:recvInts 0 0 mpi:COMM/WORLD)))
        (printf "[~a]Received data: ~a~n" rank data)))

(define finalized? (mpi:finalize))
