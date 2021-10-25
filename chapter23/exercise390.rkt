;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise390) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 390

(define-struct branch [left right])

; A TOS is one of:
; – Symbol
; – (make-branch TOS TOS)
 
; A Direction is one of:
; – 'left
; – 'right

; A list of Directions is also called a path.

(define end (make-branch 'x 'y))
(define tree (make-branch end end))

; TOS [List-of Direction] -> TOS
(check-expect (tree-pick tree '()) tree)
(check-expect (tree-pick tree '(left)) end)
(check-expect (tree-pick tree '(left left)) 'x)
(check-expect (tree-pick tree '(right right)) 'y)
(check-error (tree-pick tree '(right right right right))
             "cannot traverse a symbol further")
(define (tree-pick tree path)
  (cond
    [(and
      (cons? path)
      (symbol? tree))
     (error "cannot traverse a symbol further")]
    [(empty? path) tree]
    [(equal? (first path) 'left)
     (tree-pick (branch-left tree) (rest path))]
    [(equal? (first path) 'right)
     (tree-pick (branch-right tree) (rest path))]))