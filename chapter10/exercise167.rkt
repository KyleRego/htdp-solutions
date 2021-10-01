;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise167) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 167

; a List-of-Posns is one of:
; - '()
; (cons Posn list-of-Posns)


; List-of-Posns -> Number
; computes the sum of all the x coordinates
; of the posns in the list of posns
(check-expect (sum '()) 0)
(check-expect (sum (cons (make-posn 2 4) '())) 2)
(define (sum alop)
  (cond
    [(empty? alop) 0]
    [else (+ (posn-x (first alop)) (sum (rest alop)))]))