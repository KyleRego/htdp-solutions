;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise150) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 150

; An N is one of: 
; – 0
; – (add1 N)
; interpretation represents the counting numbers

; N -> Number
; computes (+ n pi) without using +
(check-within (add-to-pi 3) (+ 3 pi) 0.001)
(check-within (add-to-pi 5) (+ 5 pi) 0.001)
(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [else (+ 1 (add-to-pi (- n 1)))]))

; N Number -> Number
; adds a natural number n to arbitrary number x
(check-expect (add 2 3.1) 5.1)
(check-expect (add 5 -0.4) 4.6)
(define (add n x)
  (cond
    [(zero? n) x]
    [else (+ 1 (add (- n 1) x))]))