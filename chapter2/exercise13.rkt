;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 11

(define (dist-from-origin x y)
  (sqrt (+ (sqr x) (sqr y))))

; exercise 12

(define (cvolume x)
  (* x x x))

(define (csurface x)
  (* 6 (sqr x)))

; exercise 13

(define (string-first str)
  (substring str 0 1))





   