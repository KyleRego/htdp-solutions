;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise64) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 64

(check-expect (manhattan-distance (make-posn 2 0)) 2)
(check-expect (manhattan-distance (make-posn 0 2)) 2)
(check-expect (manhattan-distance (make-posn 2 2)) 4)

(define (manhattan-distance p)
  (+ (posn-x p) (posn-y p)))