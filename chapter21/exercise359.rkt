;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise359) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 359

(require 2htdp/abstraction)

(define-struct add [left right])
(define-struct mul [left right])
(define-struct fun [name expression])
; A BSL-fun-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-fun-expr BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)
; - (make-fun Symbol BSL-fun-expr)

(define-struct fun-def [name parameter body])
; A BSL-fun-def is a structure:
;    (make-fun-def Symbol Symbol BSL-fun-expr)
; interpretation represents
; (define (name parameter) body)

; a BSl-fun-def* is a [List-of BSL-fun-def]

(define f (make-fun-def 'f 'x (make-add 3 'x)))
(define g (make-fun-def 'g 'y (make-fun 'f (make-mul 2 'y))))
(define h (make-fun-def 'h 'v (make-add (make-fun 'f 'v) (make-fun 'g 'v))))

(define da-fgh (list f g h))

; BSL-fun-def* Symbol -> BSL-fun-def
; retrieves the definition of f in da
; signals an error if there is none
(check-expect (lookup-def da-fgh 'g) g)
(define (lookup-def da f)
  (for/or ([fdef da]) (if
                       (equal? (fun-def-name fdef) f)
                       fdef
                       #false)))

; BSL-var-expr Symbol Number -> BSL-var-expr
; produces a BSL-var-expr with all instances
; of x replaced by v
(check-expect (subst 5 'x 3) 5)
(check-expect (subst 'x 'x 5) 5)
(check-expect (subst 'x 'y 5) 'x)
(check-expect (subst (make-add 'x 2) 'x 2) (make-add 2 2))
(check-expect (subst (make-add (make-add 'x 2) 2) 'x 3)
              (make-add (make-add 3 2) 2))
(check-expect (subst (make-mul (make-mul 'y 2) (make-mul 'y 2)) 'y 3)
              (make-mul (make-mul 3 2) (make-mul 3 2)))
(define (subst ex x v)
  (cond
    ([number? ex] ex)
    ([symbol? ex] (if (equal? ex x) v ex))
    ([add? ex] (make-add
                (subst (add-left ex) x v)
                (subst (add-right ex) x v)))
    ([mul? ex] (make-mul
                (subst (mul-left ex) x v)
                (subst (mul-right ex) x v)))
    ([fun? ex] (make-fun
                (subst (fun-name ex) x v)
                (subst (fun-expression ex) x v)))))


; BSL-fun-expr BSL-fun-def* -> Number
(check-expect (eval-function* (make-fun 'f 5) da-fgh) 8)
(check-expect (eval-function* (make-fun 'g 2) da-fgh) 7)
(check-expect (eval-function* (make-fun 'h 1) da-fgh) 9)
(check-error (eval-function* (make-fun 'o 1) da-fgh) "unknown function")
(check-error (eval-function* 'x da-fgh) "unknown symbol")
(define (eval-function* ex da)
  (cond
    [(number? ex) ex]
    ([add? ex] (+ (eval-function* (add-left ex) da) (eval-function* (add-right ex) da)))
    ([mul? ex] (* (eval-function* (mul-left ex) da) (eval-function* (mul-right ex) da)))
    ([fun? ex] (if
                (false? (lookup-def da (fun-name ex)))
                (error "unknown function")
                (local
                  ((define value (eval-function* (fun-expression ex) da))
                   (define f (lookup-def da (fun-name ex)))
                   (define plugd (subst (fun-def-body f) (fun-def-parameter f) value)))
                  (eval-function* plugd da))))
    ([symbol? ex] (error "unknown symbol"))))
