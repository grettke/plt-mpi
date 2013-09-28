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

(printf "==========================\n")
(printf "       IN OUT: SIMPLE\n")
(printf "==========================\n")

(printf "s/addInt(2 2) Call (got): ~a~n" (s/addInt 2 2))