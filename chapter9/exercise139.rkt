;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise139) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 139

; A List-of-numbers is one of: 
; – '()
; – (cons Number List-of-numbers)


; List-of-numbers -> Boolean
; returns a bool representing if all
; the numbers in a List-of-numbers are positive
(check-expect (pos? '()) #true)
(check-expect (pos? (cons -2 '())) #false)
(check-expect (pos? (cons 2 '())) #true)
(check-expect (pos? (cons 2 (cons -2 '()))) #false)
(check-expect (pos? (cons 5 (cons 4 '()))) #true)
(define (pos? alon)
  (cond
    [(empty? alon) #true]
    [else (and
           (> (first alon) 0)
           (pos? (rest alon)))]))

; A List-of-amounts is one of: 
; – '()
; – (cons PositiveNumber List-of-amounts)

; List-of-amounts -> Number
; computes the sum of the amounts in a List-of-amounts
(check-expect (sum '()) 0)
(check-expect (sum (cons 5 '())) 5)
(check-expect (sum (cons 2 (cons 2 '()))) 4)
(define (sum aloa)
  (cond
    [(empty? aloa) 0]
    [else (+ (first aloa) (sum (rest aloa)))]))

; List-of-numbers -> Number
; checks that a List-of-numbers is a List-of=amounts
; and if so, computes the sum; otherwise signals an error
(check-expect (checked-sum '()) 0)
(check-expect (checked-sum (cons 3 '())) 3)
(check-error (checked-sum (cons -2 '()))
             "checked-sum: not given a List-of-amounts")
(define (checked-sum alon)
  (cond
    [(pos? alon) (sum alon)]
    [else (error "checked-sum: not given a List-of-amounts")]))