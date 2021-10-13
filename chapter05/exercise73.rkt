;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise73) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 73

; Posn Number -> Posn
; takes a posn and number and returns a new posn with the same y
; as the old posn but with x replaced by the number
(check-expect (posn-up-x (make-posn 5 10) 6) (make-posn 6 10))
(define (posn-up-x p n)
  (make-posn n (posn-y p)))