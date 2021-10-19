;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise323) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 323

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

; BT Number -> [Maybe Symbol]
; returns name field of the node with ssn num
; or false if no such node exists
(check-expect (search-bt tree1 24) 'i)
(check-expect (search-bt tree1 0) #false)
(check-expect (search-bt tree2 87) 'h)
(define (search-bt bt num)
  (if
   (contains-bt? bt num)
   (if (= (node-ssn bt) num)
       (node-name bt)
       (if (equal? (search-bt (node-left bt) num) #false)
           (search-bt (node-right bt) num)
           (search-bt (node-left bt) num))) #false))
   
   
