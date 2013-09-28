#lang scheme

(require (prefix-in mpi: "mpi.ss"))

(define initialized? (mpi:init))

(define comm-rank-result (mpi:comm-rank))
(define rank (mpi:result-value comm-rank-result))

(when (= rank 0)
      (let ((status (mpi:sendInts '(1 2 3 4 5) 1 0 mpi:COMM/WORLD)))
        (printf "[~a]Send status: ~a~n" rank status)))

(when (= rank 1)
      (let ((data (mpi:recvInts 0 0 mpi:COMM/WORLD)))
        (printf "[~a]Received data: ~a~n" rank data)))

(define finalized? (mpi:finalize))
