;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise261) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 261

(define-struct IR
  [name price])
; An IR is a structure:
;   (make-IR String Number)
; An Inventory is one of: 
; – '()
; – (cons IR Inventory)

(define EXINVENTORY
  (list
   (make-IR "apple" 0.60)
   (make-IR "banana" 0.79)
   (make-IR "mango" 5)))

; Inventory -> Inventory
; creates an Inventory from an-inv for all
; those items that cost less than a dollar
(define (extract1 an-inv)
  (cond
    [(empty? an-inv) '()]
    [else
     (local ((define firstone (first an-inv))
             (define extractedrest (extract1 (rest an-inv))))
             (cond
               [(<= (IR-price firstone) 1.0)
                (cons firstone extractedrest)]
               [else extractedrest]))]))

(extract1 EXINVENTORY)