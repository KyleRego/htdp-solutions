;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise272) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 272

(require 2htdp/image)
(define square1 (square 40 "solid" "blue"))
(define square2 (square 25 "solid" "yellow"))
(define square3 (square 10 "solid" "red"))

(define square-list (list square1 square2 square3))

; List List -> List
; concatenates the two lists to form a new list
(check-expect (append-from-fold (list 1 2 3)
                                (list 4 5 6 7 8))
              (list 1 2 3 4 5 6 7 8))

(define (append-from-fold list1 list2)
  (local (
          (define (f list-element base)
            (cons list-element base)))
  (foldr f list2 list1)))

; [List=of Number] -> Number
; computes the sum of a list of numbers
(check-expect (sum (list 1 2 3)) 6)
(define (sum alon)
  (local (; Number Number -> Number
          (define (f num base)
            (+ num base)))
  (foldr f 0 alon)))

; [List=of Number] -> Number
; computes the product of a list of numbers
(check-expect (product (list 1 2 3)) 6)
(define (product alon)
  (local (; Number Number -> Number
          (define (f num base)
            (* num base)))
  (foldr f 1 alon)))

; [List-of Image] -> Image
(define (horizontal-images aloi)
  (local (; Image Image -> Image
          ; makes a new image by placing
          ; im1 and im2 next to each other
          (define (append-ims im1 im2)
            (beside im1 im2)))
    (foldl append-ims empty-image aloi)))

(horizontal-images square-list)