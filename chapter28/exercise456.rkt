;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise456) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 456

(define ε 0.1)

; computes the slope of f at r1
(check-expect (slope
               (lambda (x) (* 2 x))
               2)
              2)
(check-expect (slope
               (lambda (x) (* 2 x x))
               2)
              8)
(define (slope f r1)
  (/
   (- (f (+ r1 ε)) (f (- r1 ε)))
   (* 2 ε)))

(check-expect (root-of-tangent
               (lambda (x) (* 2 x))
               2)
              0)
(define (root-of-tangent f r1)
  (- r1 (/
         (f r1)
         (slope f r1))))