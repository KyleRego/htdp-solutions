;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise394) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 394

; [List-of Number] [List-of Number] -> [List-of Number]
; takes two sorted (ascending) lists of numbers and
; makes a single sorted list of all the numbers of both lists
(check-expect (merge '(1 2 3 4) '(5 6 7 8)) '(1 2 3 4 5 6 7 8))
(check-expect (merge '(1 6 7) '(1 2 4 8)) '(1 1 2 4 6 7 8))
(check-expect (merge '(1 2 4 5) '(3)) '(1 2 3 4 5))
(define (merge alon1 alon2)
  (cond
    [(empty? alon1) alon2]
    [(empty? alon2) alon1]
    [else
      (if
       (<= (first alon1) (first alon2))
       (cons (first alon1) (merge (rest alon1) alon2))
       (cons (first alon2) (merge alon1 (rest alon2))))]))