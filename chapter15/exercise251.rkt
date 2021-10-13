;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise251) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 251

(define (fold1 l accumulator initval)
  (cond
    [(empty? l) initval]
    [else
     (accumulator (first l)
                  (fold1 (rest l)
                         accumulator
                         initval))]))

(check-expect (sum '(1 2 3 4)) 10)
(define (sum l)
  (fold1 l + 0))


(check-expect (product '(1 2 3 4)) 24)
(define (product l)
  (fold1 l * 1))