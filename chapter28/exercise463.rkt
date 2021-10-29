;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise463) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 462 + 463

(require 2htdp/abstraction)

(define M ; an SOE 
  (list (list 2 2  3 10) ; an Equation 
        (list 2 5 12 31)
        (list 4 1 -2  1)))

(define M2
  (list
   (list 2 2 3 10)
   (list 0 3 9 21)
   (list 0 0 1 2)))

(define S '(1 1 2)) ; a Solution

; [List-of Number] [List-of Number] -> Number
; produces the linear combination of the two lists
(check-expect (value (list 5) (list 1)) 5)
(check-expect (value (list 5 17) (list 2 1)) 27)
(check-expect (value (list 5 17 3) (list 1 1 1)) 25)
(define (value alon1 alon2)
  (for/sum ((num1 alon1) (num2 alon2)) (* num1 num2)))

; Equation -> [List-of Number]
; extracts the left-hand side from a row in a matrix
(check-expect (lhs (first M)) '(2 2 3))
(define (lhs e)
  (reverse (rest (reverse e))))
 
; Equation -> Number
; extracts the right-hand side from a row in a matrix
(check-expect (rhs (first M)) 10)
(define (rhs e)
  (first (reverse e)))

; SOE Solution -> Boolean
(check-expect (check-solution M S) #true)
(check-expect (check-solution M2 S) #true)
(define (check-solution m s)
  (for/and ((m-row m))
    (= (value (lhs m-row) s) (rhs m-row))))
    
