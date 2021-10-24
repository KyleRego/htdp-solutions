;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise353) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 353

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