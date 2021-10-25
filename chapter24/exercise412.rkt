;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise412) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 412

(define-struct inex [mantissa sign exponent])
; An Inex is a structure: 
;   (make-inex N99 S N99)
; An S is one of:
; – 1
; – -1
; An N99 is an N between 0 and 99 (inclusive).

; N Number N -> Inex
; makes an instance of Inex after checking the arguments
(define (create-inex m s e)
  (cond
    [(and (<= 0 m 99) (<= 0 e 99) (or (= s 1) (= s -1)))
     (make-inex m s e)]
    [else (error "bad values given")]))

; Inex Inex -> Inex
; adds together two Inex numbers that have
; the same exponent
(check-expect (inex+
               (create-inex 10 1 50)
               (create-inex 10 1 50))
              (create-inex 20 1 50))
(check-expect (inex+
               (create-inex 90 1 50)
               (create-inex 10 1 50))
              (create-inex 10 1 51))
(check-expect (inex+
               (create-inex 1 -1 10)
               (create-inex 1 -1 10))
              (create-inex 2 -1 10))
(check-expect (inex+
               (create-inex 9 -1 10)
               (create-inex 1 -1 10))
              (create-inex 10 -1 10))
(check-expect (inex+
               (create-inex 10 -1 10)
               (create-inex 90 -1 10))
              (create-inex 10 -1 11))
(check-error (inex+
              (create-inex 99 1 99)
              (create-inex 1 1 99))
             "inex+: result was too big to represent as inex")
(define (inex+ one two)
  (local ((define new-mantissa (+
                                (inex-mantissa one)
                                (inex-mantissa two))))
    (if (<= 100 new-mantissa)
        (if (>= 99 (+ 1 (inex-exponent one)))
            (make-inex (/ new-mantissa 10)
                       (inex-sign one)
                       (+ 1 (inex-exponent one)))
            (error "inex+: result was too big to represent as inex"))
        (make-inex new-mantissa (inex-sign one) (inex-exponent one)))))
     
  