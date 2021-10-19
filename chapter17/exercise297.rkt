;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise297) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 297

; Number Number Posn -> Number
; computes the distance between x and y
; and pos
(check-expect (distance-between 0 0 (make-posn 3 4)) 5)
(check-expect (distance-between 1 1 (make-posn 2 1)) 1)
(define (distance-between x y pos)
  (sqrt
   (+
    (sqr (- (posn-x pos) x))
    (sqr (- (posn-y pos) y)))))
  