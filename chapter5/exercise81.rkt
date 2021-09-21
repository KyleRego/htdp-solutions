;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise81) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 81


; a Time is a structure
;     (make-time Number Number Number)
; interpretation the time passed since midnight
(define-struct time [hours minutes seconds])


; Time -> Number
; takes Time t and computes
; the number of seconds since midnight
(check-expect (time->seconds (make-time 1 0 0)) 3600)
(check-expect (time->seconds (make-time 0 0 60)) 60)
(check-expect (time->seconds (make-time 12 30 2)) 45002)
(define (time->seconds t)
  (+ (* (time-hours t) 3600) (* (time-minutes t) 60) (time-seconds t)))
