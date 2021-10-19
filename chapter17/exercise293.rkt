;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise293) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 293

; [X] X [List-of X] -> [Maybe [List-of X]]
; returns the first sublist of l that starts
; with x, #false otherwise
(define (find x l)
  (cond
    [(empty? l) #false]
    [else
     (if (equal? (first l) x) l (find x (rest l)))]))

; [X] X [List-of X] -> [[Maybe [List-of X]} -> Boolean]
; produces a predicate which determines if a list l
; starts with given x, and is a sublist of a-list
; or if given false, determines that x was not in a-list
(define (found? x a-list)
  (lambda (l)
    (cond
      [(false? l) (not (member? x a-list))]
      [else
       (and
        (equal? (first l) x)
        (sublist? l a-list))])))

; [List-of X] [List-of X] -> Boolean
; determines if L1 is a sublist of L2
(check-expect (sublist? '(1 2 3) '(1 2 3)) #true)
(check-expect (sublist? '(1 2 3) '(3 1 2 3)) #true)
(define (sublist? L1 L2)
  (cond
    [(empty? L2) #false]
    [(equal? L1 L2) #true]
    [else (sublist? L1 (rest L2))]))
   



(check-satisfied (find 5 '(1 2 3)) (found? 5 '(1 2 3)))
(check-satisfied (find 5 '(1 2 3 4 5)) (found? 5 '(1 2 3 4 5)))