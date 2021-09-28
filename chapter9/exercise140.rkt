;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise140) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 140

; a List-of-bools is one of:
; - '()
; - (cons Boolean List-of-bools)

; List-of-bools -> Boolean
; returns #true if all bools in the
; List-of-bools are #true
(check-expect (all-true '()) #true)
(check-expect (all-true (cons #false '())) #false)
(check-expect (all-true (cons #true '())) #true)
(check-expect (all-true (cons #true (cons #false '())))
              #false)
(define (all-true alob)
  (cond
    [(empty? alob) #true]
    [(and
      (first alob)
      (all-true (rest alob))) #true]
    [else #false]))

; List-of-bools -> Boolean
; returns #true if one bool in the
; List-of-bools is #true
(check-expect (one-true '()) #false)
(check-expect (one-true (cons #true '())) #true)
(check-expect (one-true (cons #false
                              (cons #true
                                    (cons #false
                                          (cons #false '()))))) #true)
(define (one-true alob)
  (cond
    [(empty? alob) #false]
    [(or
      (first alob)
      (one-true (rest alob))) #true]))