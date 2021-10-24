;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise357) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 357

(define-struct add [left right])
(define-struct mul [left right])
(define-struct fun [name expression])
; A BSL-fun-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-fun-expr BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)
; - (make-fun Symbol BSL-fun-expr)

; (make-fun f x) represents (f x)

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
                (subst (mul-right ex) x v)))))


; BSL-fun-expr Symbol Symbol BSL-fun-expr -> Number
; determines the value of ex
(check-expect (eval-definition1 (make-fun 'f 5) 'f 'x (make-mul 'x 2)) 10)
(check-expect (eval-definition1 (make-fun 'g 2) 'g 'x (make-add 'x 1)) 3)
(check-error (eval-definition1 (make-mul 'x 2) 'g 'x (make-mul 'x 2)) "unknown variable")
(check-error (eval-definition1 (make-fun 'g 2) 'f 'x (make-mul 'x 2)) "unknown function")
(define (eval-definition1 ex f x b)
  (cond
    [(number? ex) ex]
    ([add? ex] (+ (eval-definition1 (add-left ex) f x b) (eval-definition1 (add-right ex) f x b)))
    ([mul? ex] (* (eval-definition1 (mul-left ex) f x b) (eval-definition1 (mul-right ex) f x b)))
    ([fun? ex] (if
                (equal? (fun-name ex) f)
                (local ((define value (eval-definition1 (fun-expression ex) f x b))
                        (define plugd (subst b x value)))
                  (eval-definition1 plugd f x b))
               (error "unknown function")))
    ([symbol? ex] (error "unknown variable"))))