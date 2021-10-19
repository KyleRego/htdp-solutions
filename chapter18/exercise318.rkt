;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise318) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 318

; An Atom is one of: 
; – Number
; – String
; – Symbol

; An S-expr is one of: 
; – Atom
; – SL
 
; An SL is one of: 
; – '()
; – (cons S-expr SL)

; Any -> Boolean
; determines if x is an Atom
(define (atom? x)
  (or
   (number? x)
   (string? x)
   (symbol? x)))


; S-expr -> Number
; determines the depth of an S-expr
(check-expect (depth "hello world") 1)
(check-expect (depth '()) 1)
(check-expect (depth '( "hello world")) 2)
(check-expect (depth '( 1 ( 2 ( 1 2 3 "hello")))) 4)
(check-expect (depth '(1 ( "hello world" ))) 3)
(check-expect (depth (list (list "hello world"))) 3)


(define (depth sexp)
  (cond
    [(atom? sexp) 1]
    [else (depth-sl sexp)]))

(define (depth-sl sexp)
  (cond
    [(empty? sexp) 1]
    [else
     (+ 1 (apply max (map depth sexp)))]))

  
  