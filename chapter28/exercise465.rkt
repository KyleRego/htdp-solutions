;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise465) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 465

(require 2htdp/abstraction)

(define M ; an SOE 
  (list (list 2 2  3 10) ; an Equation 
        (list 2 5 12 31)
        (list 4 1 -2  1)))

; Equation Equation -> Equation
; subtracts a multiple of the second Equation
; from the first Equation to give an Equation
; with the first term 0, and drops that term
(check-expect (subtract
               (list 2 2 3 10)
               (list 2 5 12 31))
              (list -3 -9 -21))
(check-expect (subtract
               (list 3 3 3 2)
               (list 3 2 2 1))
              (list 1 1 1))

(check-expect (subtract
               (list 4 8 8 8)
               (list 2 4 4 2))
              (list 0 0 4))

(define (subtract eq1 eq2)
  (local ((define multiple
            (/ (first eq1)
               (first eq2))))
    (rest (for/list ((x eq1) (y eq2))
            (- x (* multiple y))))))