;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise322) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 322

(define-struct no-info [])
(define NONE (make-no-info))
 
(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

(define tree1 (make-node
               15
               'd
               NONE
               (make-node
                24 'i NONE NONE)))

(define tree2 (make-node
               15
               'd
               (make-node
                87 'h NONE NONE)
               NONE))

; BT Number -> Boolean
; determines whether some num occurs in bt
(check-expect (contains-bt? tree1 24) #true)
(check-expect (contains-bt? tree1 0) #false)
(define (contains-bt? bt num)
  (cond
    [(equal? bt NONE) #false]
    [else
     (or
      (equal? (node-ssn bt) num)
      (contains-bt? (node-left bt) num)
      (contains-bt? (node-right bt) num))]))