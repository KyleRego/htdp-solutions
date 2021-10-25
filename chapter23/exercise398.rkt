;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise398) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 398

(require 2htdp/abstraction)

; [List-of Number] [List-of Number] -> Number
; produces the linear combination of the two lists
(check-expect (value (list 5) (list 1)) 5)
(check-expect (value (list 5 17) (list 2 1)) 27)
(check-expect (value (list 5 17 3) (list 1 1 1)) 25)
(define (value alon1 alon2)
  (for/sum ((num1 alon1) (num2 alon2)) (* num1 num2)))
