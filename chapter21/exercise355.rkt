;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise355) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 355

(define-struct add [left right])
(define-struct mul [left right])
; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

; A BSL-expr is one of:
; - Number
; - (make-add BSL-expr BSL-expr)
; - (make-mul BSL-expr BSL-expr)

; An AL (short for association list) is [List-of Association].
; An Association is a list of two items:
;   (cons Symbol (cons Number '())).

; BSL-var-expr -> Boolean
; determines whether a BSL-var-expr
; is also a BSL-expr
(check-expect (numeric? 'x) #false)
(check-expect (numeric? 5) #true)
(check-expect (numeric? (make-mul 'x 5)) #false)
(check-expect (numeric? (make-mul 5 5)) #true)
(check-expect (numeric? (make-add 'x 5)) #false)
(check-expect (numeric? (make-add (make-mul 2 2) (make-mul 'x 3))) #false)
(define (numeric? ex)
  (cond
    ([symbol? ex] #false)
    ([number? ex] #true)
    ([add? ex] (and
                (numeric? (add-left ex))
                (numeric? (add-right ex))))
    ([mul? ex] (and
                (numeric? (mul-left ex))
                (numeric? (mul-right ex))))))

; BSL-expr -> BSL-expr
; evaluates a BSL-expr to its value
(define (eval-expression expr)
  (cond
    ([add? expr] (+ (eval-expression (add-left expr)) (eval-expression (add-right expr))))
    ([mul? expr] (* (eval-expression (mul-left expr)) (eval-expression (mul-right expr))))
    ([number? expr] expr)))

; BSL-var-expr -> BSL-var-expr
; evalutes a BSL-var-expr if numeric? yields true
; for the input, otherwise throws an error
(check-error (eval-variable 'x) "eval-variable: ex must not be a symbol")
(check-expect (eval-variable (make-add 2 5)) 7)
(check-expect (eval-variable (make-mul 10 10)) 100)
(define (eval-variable ex)
  (cond
    [(not (numeric? ex)) (error "eval-variable: ex must not be a symbol")]
    [else (eval-expression ex)]))

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

; BSL-var-expr AL -> Number
(check-expect (eval-var-lookup 5 '()) 5)
(check-expect (eval-var-lookup 'x '( (x 5))) 5)
(check-expect (eval-var-lookup (make-add 'x 2) '( (x 2))) 4)
(check-expect (eval-var-lookup (make-mul 'x 'x) '( (x 2))) 4)
(check-expect (eval-var-lookup (make-mul 'x 'y) '( (x 2) (y 4))) 8)
(check-error (eval-var-lookup 'x '()) "eval-var-lookup: symbol not found in da")
(define (eval-var-lookup ex da)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (if
                   (false? (assq ex da))
                   (error "eval-var-lookup: symbol not found in da")
                   (second (assq ex da)))]
    ([add? ex] (+
                (eval-var-lookup (add-left ex) da)
                (eval-var-lookup (add-right ex) da)))
    ([mul? ex] (*
                (eval-var-lookup (mul-left ex) da)
                (eval-var-lookup (mul-right ex) da)))))
             
                   