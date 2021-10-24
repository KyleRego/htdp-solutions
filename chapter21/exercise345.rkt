;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise345) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 345

(define-struct add [left right])
; an Addition is a structure:
;     (make-add Expression Expression)
; interpretation represents an addition

(define-struct mul [left right])
; a Multiplication is a structure:
;    (make-mul Expression Expression)
; interpretation represents a multiplication

; An Expression is a:
; - Number
; - Addition
; - Multiplication

(make-add 10 -10)

(make-add (make-mul 20 3) 33)

(make-add (make-mul 3.14 (make-mul 2 3)) (make-mul 3.14 (make-mul -1 -9)))

(+ -1 2)

(+ (* -2 -3) 33)

(* (+ 1 (* 2 3)) 3.14)