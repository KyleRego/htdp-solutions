;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise445) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 445

; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R ε)]
; assume f is continuous 
; (2) (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divides interval in half, the root is in 
; one of the two halves, picks according to (2)
(check-satisfied (find-root poly 1 3) (within-root poly))
(check-satisfied (find-root poly 3 5) (within-root poly))
(define (find-root f left right)
  0)

; Number -> Number
(define (poly x)
  (* (- x 2) (- x 4)))

(define (within-root f)
  (lambda (x) (< (f x) 0.2)))