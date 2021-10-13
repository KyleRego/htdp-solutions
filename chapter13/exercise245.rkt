;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise245) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 245

; Function Function -> Boolean
; determines whether f1 and f2 return
; equal values for inputs 1.2, 3, and 5.775
(check-expect (function=at-1.2-3-and-5.775?
               plus1
               plus1v2) #true)
(define (function=at-1.2-3-and-5.775? f1 f2)
  (and
   (= (f1 1.2) (f2 1.2))
   (= (f1 3) (f2 3))
   (= (f1 5.775) (f2 5.775))))

(define (plus1 x)
  (+ 1 x))

(define (plus1v2 x)
  (- (+ 2 x) 1))

; I don't think its possible to define function=? because
; it would need to check an infinite number of inputs to
; determine whether the functions compute the same value
; for all inputs