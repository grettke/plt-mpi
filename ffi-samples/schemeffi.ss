#lang scheme

(require scheme/foreign) (unsafe!)

(define libsample (ffi-lib "libsample"))

(define s/sayHi
  (get-ffi-obj "sayHi" libsample
	       (_fun -> _void)))

(define s/getInt42
  (get-ffi-obj "getInt42" libsample
	       (_fun -> _int)))

(define s/getHw
  (get-ffi-obj "getHw" libsample
               (_fun -> _string)))

(define s/addInt
  (get-ffi-obj "addInt" libsample
               (_fun _int _int -> _int)))

; int* getSimpleInts(void)
; An array of 5 integers
(define s/getSimpleInts
  (get-ffi-obj "getSimpleInts" libsample
               (_fun -> (_list o _int 5))))

; void printSimpleInts(int, int*)
; Print an array of integers for the given count
(define s/printSimpleInts
  (get-ffi-obj "printSimpleInts" libsample
               (_fun (args)
                     ::
                     [len : _int = (length args)]
                     [args : (_list io _int len)]
                     ->
                     _void)))

(printf "==========================\n")
(printf "       NO IN NO OUT\n")
(printf "==========================\n")

(printf "s/sayHi Call (see below): ~n")
(s/sayHi)

(printf "==========================\n")
(printf "       OUT ONLY: SIMPLE\n")
(printf "==========================\n")

(printf "s/getInt42 Call (got): ~a~n" (s/getInt42))

(printf "s/getHw Call (got): ~a~n" (s/getHw))

(printf "s/getSimpleInts Call (got): ~a~n" (s/getSimpleInts))

(printf "s/printSimpleInts Call (see below): ~n")
(s/printSimpleInts '(6 7 8 9 10))

(printf "==========================\n")
(printf "       IN OUT: SIMPLE\n")
(printf "==========================\n")

(printf "s/addInt(2 2) Call (got): ~a~n" (s/addInt 2 2))
