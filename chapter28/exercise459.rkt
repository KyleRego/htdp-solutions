;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise459) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 459

(define ε 0.01)
(define R 1000)
 
; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b
; assume (< a b) holds 
 
(check-within (integrate (lambda (x) 20) 12 22) 200 ε)
(check-within (integrate (lambda (x) (* 2 x)) 0 10) 100 ε)
(check-within (integrate (lambda (x) (* 3 (sqr x))) 0 10)
              1000
              ε)
 
(define (integrate f a b)
  (local ((define W (/ (- b a) R))
          (define S (/ W 2))
          (define (helper f a b sum it)
            (cond
              [(= it R) sum]
              (else
               (helper f a b
                       (+ sum (* W (f (+ a (* it W) S))))
                       (+ it 1))))))
    (helper f a b (* W (f (+ a S))) 1)))