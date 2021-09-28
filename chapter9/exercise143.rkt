;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise143) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 143

; List-of-temperatures -> Number
; computes the average temperature
(check-expect
  (average (cons 1 (cons 2 (cons 3 '())))) 2)

(define (average alot)
  (/ (sum alot) (how-many alot)))

; List-of-temperatures -> Number 
; adds up the temperatures on the given list 
(define (sum alot)
  (cond
    [(empty? alot) 0]
    [else (+ (first alot) (sum (rest alot)))]))

; List-of-temperatures -> Number
; returns the number of temperatures in the list
(define (how-many alot)
  (cond
    [(empty? alot) 0]
    [else (+ (how-many (rest alot)) 1)]))

; List-of-temperatures -> Number
; computes the average temperature or
; returns an error if empty list is given
(check-error (checked-average '())
             "cannot take average of empty list")
(check-expect (checked-average (cons 2 '())) 2)
(define (checked-average alot)
  (cond
    [(empty? alot) (error "cannot take average of empty list")]
    [else (average alot)]))


