;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise324) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 324

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

; BT -> [List-of Number]
; produces sequence of ssn numbers
; in the tree as they show from left to right
; when looking at a tree drawing
(check-expect (inorder tree1) (list 15 24))
(check-expect (inorder tree2) (list 87 15))
(define (inorder bt)
  (cond
    [(equal? bt NONE) '()]
    [else
     (append
      (inorder (node-left bt))
      (list (node-ssn bt))
      (inorder (node-right bt)))]))