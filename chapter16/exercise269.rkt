;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise269) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 269

; Inventory is a structure:
(define-struct inventory [name desc a-price s-price])

(define inv1 (make-inventory "apple" "a fruit" 0.50 1))
(define inv2 (make-inventory "orange" "a fruit" 0.40 1))
(define inv3 (make-inventory "kiwi" "a fruit" 0.75 2))
(define list-inv (list inv1 inv2 inv3))

; Number [List=of Inventory] -> [List-of Inventory]
; filters the list to those items with sales price below ua
(check-expect (eliminate-expensive 2.1 list-inv) list-inv)
(check-expect (eliminate-expensive 0.2 list-inv) '())
(define (eliminate-expensive ua aloi)
  (local (; Inventory -> Boolean
          ; determines if sales-price is lower than ua
          (define (helper inv)
            (> ua (inventory-s-price inv))))
  (filter helper aloi)))

; String [List-of Inventory] -> [List-of Inventory]
; filters the list to those items without the name ty
(check-expect (recall "apple" list-inv) (list inv2 inv3))
(define (recall ty aloi)
  (local (; String Inventory -> Boolean
          ; true if Inventory's name is not the string
          (define (helper inv)
            (not
             (string=? ty (inventory-name inv)))))
  (filter helper aloi)))


; [List-of String] [List-of String] -> [List-of String]
; filters the second list by selecting all names that are
; on the first list
(check-expect (selection
               (list "apple" "orange")
               (list "apple" "banana" "kiwi")) (list "apple"))
(define (selection alos1 alos2)
  (local (; String -> Boolean
          ; return true if str
          ; is in alos1
          (define (helper str)
            (member? str alos1)))
            
  (filter helper alos2)))