;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise162) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 162

; List-of-numbers -> List-of-numbers
; computes the weekly wages for all given weekly hours
(check-expect (wage* '()) '())
(check-expect (wage* (cons 2 '())) (cons 24 '()))
(check-error (wage* (cons 102 '())) "employee with more than 100 hours")
(check-expect (wage* (cons 2 (cons 3 '()))) (cons 24 (cons 36 '())))
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else (if (> (first whrs) 100)
              (error "employee with more than 100 hours")
              (cons (wage (first whrs)) (wage* (rest whrs))))]))
 
; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* 12 h))