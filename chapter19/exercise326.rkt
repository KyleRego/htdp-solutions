;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise326) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 326

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

(define tree2a (make-node
                100
                "hello"
                (make-node 50 "world" NONE NONE)
                NONE))

(define tree2b (make-node
               100
               "hello"
               (make-node 50 "world" NONE NONE)
               (make-node 125 "hello world" NONE NONE)))

(define tree2c (make-node
                100
                "hello"
                (make-node 50 "world" (make-node 40 "world" NONE NONE) NONE)
                (make-node 125 "hello world" NONE NONE)))

(define tree2d (make-node
                100
                "hello"
                (make-node 50 "world" (make-node 40 "world" NONE NONE) NONE)
                (make-node 125 "hello world" NONE (make-node 150 "foo bar" NONE NONE))))

; BST Number Symbol -> BST
; inserts a new node into the BST
; to get a new BST
(check-expect (create-bst tree2a 125 "hello world") tree2b)
(check-expect (create-bst tree2b 40 "world") tree2c)
(check-expect (create-bst tree2c 150 "foo bar") tree2d)
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
      