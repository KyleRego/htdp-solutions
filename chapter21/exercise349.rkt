;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise349) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 349

(define WRONG "something went wrong")

(define-struct add [left right])
; an Addition is a structure:
;     (make-add Expression Expression)
; interpretation represents an addition

(define-struct mul [left right])
; a Multiplication is a structure:
;    (make-mul BSL-expr BSL-expr)
; interpretation represents a multiplication

; a BSL-expr is a Number, Addition, or Multiplication

; Any -> Boolean
; determines if x is an Atom
(define (atom? x)
  (or
   (number? x)
   (string? x)
   (symbol? x)))

; S-expr -> BSL-expr
(check-expect (parse '(+ 3 5)) (make-add 3 5))
(check-expect (parse '(* 3 5)) (make-mul 3 5))
(check-error (parse '(3 3 3)) WRONG)
(check-error (parse '(+ 2 3 4)) WRONG)
(check-error (parse '(& 1 2)) WRONG)
(check-error (parse '(+ "hello" "world")) WRONG)
(check-error (parse '(+ + 7)) WRONG)
(define (parse s)
  (cond
    [(atom? s) (parse-atom s)]
    [else (parse-sl s)]))
 
; SL -> BSL-expr 
(define (parse-sl s)
  (cond
    [(and (consists-of-3 s) (symbol? (first s)))
     (cond
       [(symbol=? (first s) '+)
        (make-add (parse (second s)) (parse (third s)))]
       [(symbol=? (first s) '*)
        (make-mul (parse (second s)) (parse (third s)))]
       [else (error WRONG)])]
    [else (error WRONG)]))
 
; Atom -> BSL-expr 
(define (parse-atom s)
  (cond
    [(number? s) s]
    [(string? s) (error WRONG)]
    [(symbol? s) (error WRONG)]))
 
; SL -> Boolean
(define (consists-of-3 s)
  (and (cons? s) (cons? (rest s)) (cons? (rest (rest s)))
       (empty? (rest (rest (rest s))))))

; exercise 351

; BSL-expr -> BSL-expr
(define (eval-expression expr)
  (cond
    ([add? expr] (+ (eval-expression (add-left expr)) (eval-expression (add-right expr))))
    ([mul? expr] (* (eval-expression (mul-left expr)) (eval-expression (mul-right expr))))
    ([number? expr] expr)))

; S-expr -> BSL-expr
; accepts S-expressions, produces BSL-expressions
; if the S-expr is valid, otherwise throws an error
(check-expect (interpreter-expr '(+ 2 4)) 6)
(check-expect (interpreter-expr '(* 2 (* 1 2))) 4)
(check-error (interpreter-expr '(+ 2 2 2)) WRONG)
(define (interpreter-expr sexp)
  (eval-expression (parse sexp)))