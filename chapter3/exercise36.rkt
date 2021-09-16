;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise36) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; exercise 36

; Image -> Number
; takes an image and returns its area
; given (square 20 "solid" "red"), expect: 400
(define (image-area img)
  (* (image-width img) (image-height img)))


