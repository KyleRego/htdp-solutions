;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise151) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 151

; An N is one of: 
; – 0
; – (add1 N)
; interpretation represents the counting numbers

; N Number -> Number
; multiplies a natural number n with an arbitrary number x
; without using *
(check-expect (multiply 5 0.1) 0.5)
(check-expect (multiply 10 -1) -10)
(define (multiply n x)
  (cond
    [(zero? n) 0]
    [else (+ x (multiply (- n 1) x))]))