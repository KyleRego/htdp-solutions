;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise457) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 457

; computes how many months it takes
; to double the amount of money m
; in a savings account when interest
; is paid at a fixed rate r every month
(check-expect (double-amount 100 1) 1)
(check-expect (double-amount 100 0.05) 15)
(define (double-amount m r)
  (local ((define double (* 2 m))
          (define (helper m r double months)
            (cond
              [(>= (* m (+ 1 r)) double) (+ months 1)]
              [else
               (helper (* m (+ 1 r)) r double (+ months 1))])))
    (helper m r double 0)))