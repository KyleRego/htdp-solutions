;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise325) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 325

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
               100
               "hello"
               (make-node 50 "world" NONE NONE)
               (make-node 125 "hello world" NONE NONE)))

; BST Number -> Symbol or NONE
; if the BST contains a node whose ssn is n,
; produces the value of the name field in that node
; otherwise produces NONE
(check-expect (search-bst tree1 24) 'i)
(check-expect (search-bst tree1 25) NONE)
(check-expect (search-bst tree2 0) NONE)
(check-expect (search-bst tree2 100) "hello")
(check-expect (search-bst tree2 50) "world")
(check-expect (search-bst tree2 125) "hello world")
(define (search-bst bst n)
  (cond
    [(equal? bst NONE) NONE]
    [(equal? (node-ssn bst) n) (node-name bst)]
    [(> (node-ssn bst) n) (search-bst (node-left bst) n)]
    [else (search-bst (node-right bst) n)]))