;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise461) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 461

(define ε 1)

(define (integrate-kepler f a b)
  (* 1/2 (- b a) (+ (f b) (f a))))
 
; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b
; assume (< a b) holds 
 
(check-within (integrate-adaptive (lambda (x) 20) 12 22) 200 ε)
(check-within (integrate-adaptive (lambda (x) (* 2 x)) 0 10) 100 ε)
(check-within (integrate-adaptive (lambda (x) (* 3 (sqr x))) 0 10)
              1000
              ε)

(define (integrate-adaptive f a b)
  (local
    ((define width (- b a))
     (define mid (/ (+ a b) 2))
     (define trap1 (integrate-kepler f a mid))
     (define trap2 (integrate-kepler f mid b))
     (define to-comp (* ε (- b a))))
    (cond
      [(>= to-comp (- trap2 trap1))
       (integrate-kepler f a b)]
      [else
       (+
        (integrate-adaptive f a mid)
        (integrate-adaptive f mid b))])))