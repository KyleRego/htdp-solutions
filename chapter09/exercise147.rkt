;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise147) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 147

; a NEList-of-Booleans is one of:
; - (cons Boolean '())
; - (cons Boolean NEList-of-Booleans)

; NEList-of-Booleans -> Boolean
; computes whether all bools in the list
; are #true
(check-expect (all-true (cons #true '())) #true)
(check-expect (all-true (cons #false '())) #false)
(check-expect (all-true (cons #true
                              (cons #true
                                    (cons #true '())))) #true)
(check-expect (all-true (cons #false
                              (cons #true '()))) #false)
(define (all-true ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (and
           (first ne-l)
           (all-true (rest ne-l)))]))

; NEList-of-Booleans -> Boolean
; computes whether at least one bool
; in the list is #true
(check-expect (one-true (cons #true '())) #true)
(check-expect (one-true (cons #false '())) #false)
(check-expect (one-true (cons #false
                              (cons #false '()))) #false)
(check-expect (one-true (cons #true
                              (cons #false '()))) #true)
(define (one-true ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (or
           (first ne-l)
           (one-true (rest ne-l)))]))