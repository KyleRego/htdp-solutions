;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise281) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 281

(require 2htdp/image)

(define-struct IR
  [name price])

(lambda (x) (> 10 x))

(lambda (x y) (number->string (* x y)))

(lambda (x) (if (odd? x) 1 0))

(lambda (ir1 ir2) (> (IR-price ir1) (IR-price ir2)))

(lambda (pos img) (place-image (circle 5 "solid" "red")
                               (posn-x pos)
                               (posn-y pos)
                               img))