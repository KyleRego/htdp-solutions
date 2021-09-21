;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise77) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 77


; a Time is a structure
;     (make-time Number Number Number)
; interpretation: (make-time hours minutes seconds)
; is the time passed since midnight of hours hours,
; minutes minutes, and seconds seconds
(define-struct time [hours minutes seconds])