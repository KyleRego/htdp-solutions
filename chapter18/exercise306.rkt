;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise306) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 306

(require 2htdp/abstraction)

(check-expect (function1 10) '(0 1 2 3 4 5 6 7 8 9))
(define (function1 n)
  (for/list ([x n]) x))

(check-expect (function2 10) '(1 2 3 4 5 6 7 8 9 10))
(define (function2 n)
  (for/list ([x n]) (+ x 1)))

(check-expect (function3 4) '(1 1/2 1/3 1/4))
(define (function3 n)
  (for/list ([x n]) (/ 1 (+ x 1))))

(check-expect (function4 5) '(0 2 4 6 8))
(define (function4 n)
  (for/list ([x n]) (* 2 x)))