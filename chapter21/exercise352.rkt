;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise352) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 352

(define-struct add [left right])
(define-struct mul [left right])
; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

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

