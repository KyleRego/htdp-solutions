;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise358) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 358

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