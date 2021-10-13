;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise236) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 236


; Number List-of-Numbers -> List-of-Numbers
; adds the number x to every element of l
(check-expect (add 5 '(1 2 3)) '(6 7 8))
(define (add x l)
  (cond
    [(empty? l) '()]
    [else (cons (+ x (first l)) (add x (rest l)))]))

; Lon -> Lon
; adds 1 to each item on l
(check-expect (add1* '(1 2 3)) '(2 3 4))
(define (add1* l)
  (add 1 l))

; Lon -> Lon
; adds 5 to each item on l
(check-expect (plus5 '(5 5 5)) '(10 10 10))
(define (plus5 l)
  (add 5 l))

; Lon -> Lon
; subtracts 2 from each item on l
(check-expect (minus2 '(2 3 4)) '(0 1 2))
(define (minus2 l)
  (add -2 l))