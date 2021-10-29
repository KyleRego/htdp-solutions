;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise454) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 454

; creates a n x n matrix
; from a list of n^2 numbers
(check-expect (create-matrix 0 '()) '())
(check-expect (create-matrix 1 (list 1)) (list (list 1)))
(check-expect
  (create-matrix 2 (list 1 2 3 4))
  (list (list 1 2)
        (list 3 4)))
(check-expect
 (create-matrix 3 (list 1 2 3 4 5 6 7 8 9))
 (list
  (list 1 2 3)
  (list 4 5 6)
  (list 7 8 9)))

(define (create-matrix n l)
  (cond
    [(= n 0) '()]
    [else
      (mat-rest n l)]))

(check-expect (first-n 2 (list 1 2 3)) (list 1 2))
(define (first-n n l)
  (cond
    [(= n 0) '()]
    [else
     (cons (first l) (first-n (- n 1) (rest l)))]))

(check-expect (n-rest 2 (list 1 2 3)) (list 3))
(define (n-rest n l)
  (cond
    [(= n 0) l]
    [else
     (n-rest (- n 1) (rest l))]))

(check-expect (mat-rest 3 (list 4 5 6 7 8 9))
              (list
               (list 4 5 6)
               (list 7 8 9)))
(define (mat-rest n l)
  (cond
    [(= n (length l)) (list l)]
    [else
     (cons
      (first-n n l)
      (mat-rest n (n-rest n l)))]))
