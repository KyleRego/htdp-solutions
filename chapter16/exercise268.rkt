;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise268) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 268

; Inventory is a structure:
(define-struct inventory [name desc a-price s-price])

(define inv1 (make-inventory "apple" "a fruit" 0.50 1))
(define inv2 (make-inventory "orange" "a fruit" 0.40 1))
(define inv3 (make-inventory "kiwi" "a fruit" 0.75 1))
(define list-inv (list inv1 inv2 inv3))

; [List-of Inventory] -> [List-of Inventory]
; sorts according to difference between a-price and s-price
(define (sort-inventory aloi)
  (sort aloi compare-price))

(define (compare-price inv1 inv2)
  (>
   (- (inventory-a-price inv1) (inventory-s-price inv1))
   (- (inventory-a-price inv2) (inventory-s-price inv2))))

(sort-inventory list-inv)
