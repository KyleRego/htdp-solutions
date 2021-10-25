;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise413) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 413

(define-struct inex [mantissa sign exponent])
; An Inex is a structure: 
;   (make-inex N99 S N99)
; An S is one of:
; – 1
; – -1
; An N99 is an N between 0 and 99 (inclusive).

; N Number N -> Inex
; makes an instance of Inex after checking the arguments
(define (create-inex m s e)
  (cond
    [(and (<= 0 m 99) (<= 0 e 99) (or (= s 1) (= s -1)))
     (make-inex m s e)]
    [else (error "bad values given")]))

; Inex Inex -> Inex
; multiplies two Inex inputs
(check-expect (inex*
               (create-inex 1 1 1) ; 1*10
               (create-inex 1 1 1)) ; 1*10
              (create-inex 1 1 2)) ; 1*100
(check-expect (inex*
               (create-inex 1 1 0) ; 1
               (create-inex 1 1 0)) ; 1
              (create-inex 1 1 0)) ; 1
(check-expect (inex*
               (create-inex 5 1 1) ; 5*10
               (create-inex 5 1 1)) ; 5*10
              (create-inex 25 1 2))
(check-expect (inex*
               (create-inex 4 1 1) ; 4*10
               (create-inex 25 1 1)) ; 25*10
              (create-inex 10 1 3)) ; 10*10*10*10
(check-expect (inex*
               (create-inex 1 1 1); 10
               (create-inex 1 -1 1)); 1/10
              (create-inex 1 1 0))
(check-expect (inex*
               (create-inex 1 -1 1) ; 1/10
               (create-inex 1 -1 1))
              (create-inex 1 -1 2))
(define (inex* one two)
  (local ((define new-mantissa
            (* (inex-mantissa one) (inex-mantissa two)))
          (define new-exponent
            (+ (* (inex-sign one) (inex-exponent one))
               (* (inex-sign two) (inex-exponent two))))
          (define (sign expt)
            (cond
              [(> 0 expt) -1]
              [else 1]))
          (define (magnitude expt)
            (cond
              [(> 0 expt) (* -1 expt)]
              [else expt])))
    (if
     (<= 100 new-mantissa)
     (create-inex (/ new-mantissa 10)
                  (sign (+ 1 new-exponent))
                  (magnitude (+ 1 new-exponent)))
     (create-inex new-mantissa
                  (sign new-exponent)
                  (magnitude new-exponent)))))
               