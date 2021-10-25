;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise387) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 387

(require 2htdp/abstraction)

; [List-of Symbol] [List-of Number] ->
; [List-of (cons Symbol (cons Number '()))]
; produces a list of all possible ordered pairs
; of a symbol followed by a number
(check-expect (cross '(a b) '()) '())
(check-expect (cross '() '(1 2)) '())
(check-expect (cross '(a b c) '(1 2))
              '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)))
              
(define (cross alos alon)
  (for*/list ((symbol alos) (number alon))
    (list symbol number)))