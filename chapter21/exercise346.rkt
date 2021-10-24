;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise346) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 346

(define-struct add [left right])
; an Addition is a structure:
;     (make-add Expression Expression)
; interpretation represents an addition

(define-struct mul [left right])
; a Multiplication is a structure:
;    (make-mul Expression Expression)
; interpretation represents a multiplication

; an Expression is a Number, Addition, or Multiplication

; exercise 347

(define (eval-expression expr)
  (cond
    ([add? expr] (+ (eval-expression (add-left expr)) (eval-expression (add-right expr))))
    ([mul? expr] (* (eval-expression (mul-left expr)) (eval-expression (mul-right expr))))
    ([number? expr] expr)))

(eval-expression (make-add (make-mul 3.14 (make-mul 2 3)) (make-mul 3.14 (make-mul -1 -9))))