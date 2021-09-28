;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise152) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 152

(require 2htdp/image)

; An N is one of: 
; – 0
; – (add1 N)
; interpretation represents the counting numbers

; N Image -> Image
; produces an image which is a vertical arrangement
; of n copies of img
(define (col n img)
  (cond
    [(= n 1) img]
    [else (above img (col (- n 1) img))]))

; N Image -> Image
; produces an image which is a horizontal arrangement
; of n copies of img
(define (row n img)
  (cond
    [(= n 1) img]
    [else (beside img (row (- n 1) img))]))

  