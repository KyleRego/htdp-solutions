;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise253) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 253

; [Number -> Boolean]

(define (less-than-5 x)
  (> 5 x))

; [Boolean String -> Boolean]

(define (weird-function bool str)
  (and
   bool
   (> 5 (length str))))

; [Number Number Number -> Number]

(define (add3nums num1 num2 num3)
  (+ num1 num2 num2))

; [Number -> [List-of Number]]

(define (num-list-maker num)
  (list num))

; [[List-of Number] -> Boolean]

(define (first-num-is-1 alon)
  (= 1 (first alon)))