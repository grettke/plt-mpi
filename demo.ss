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

(printf "sdbg: calling sendInts~n")
(when (= rank 0)
      (mpi:sendInts
       (make-list msg-count 42)
       1))

(printf "sdbg: calling recvInts~n")
(when (= rank 1)
      (let ([the-msg (mpi:recvInts 0 msg-count)])
        (printf "I (rank ~a) received the message: ~a~n" the-msg)))

(define finalized? (mpi:finalize))