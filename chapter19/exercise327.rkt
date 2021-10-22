;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise327) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 327

(define-struct no-info [])
(define NONE (make-no-info))
 
(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

; BST Number Symbol -> BST
; inserts a new node into the BST
; to get a new BST
(define (create-bst B N S)
  (local
    ((define new-node (make-node N S NONE NONE)))
    (cond
      [(equal? B NONE) new-node]
      [(and
        (equal? (node-left B) NONE)
         (< (node-ssn new-node) (node-ssn B)))
       (make-node (node-ssn B) (node-name B) new-node (node-right B))]
      [(and
        (equal? (node-right B) NONE)
         (> (node-ssn new-node) (node-ssn B)))
       (make-node (node-ssn B) (node-name B) (node-left B) new-node)]
      [(< (node-ssn new-node) (node-ssn B))
       (make-node (node-ssn B) (node-name B) (create-bst (node-left B) N S) (node-right B))]
      [else (make-node (node-ssn B) (node-name B) (node-left B) (create-bst (node-right B) N S))])))

(define test1 '((89 c)
                (29 b)
                (63 a)))
(define bst1 (make-node 63
                        'a
                        (make-node 29 'b NONE NONE)
                        (make-node 89 'c NONE NONE)))

; [List-of [List Number Symbol]] -> BST
; produces a BST from the given list of lists
; where each list is a number and symbol
(check-expect (create-bst-from-list test1) bst1)
(define (create-bst-from-list l)
  (cond
    [(empty? l) NONE]
    [else
     (create-bst
      (create-bst-from-list (rest l))
      (first (first l))
      (second (first l)))]))
  
(create-bst-from-list '((99 o)
  (77 l)
  (24 i)
  (10 h)
  (95 g)
  (15 d)
  (89 c)
  (29 b)
  (63 a)))