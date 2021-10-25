;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise404) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 404

; [X X -> Boolean] [List-of X] [List-of X] -> Boolean
; applies f to corresponding values of list1 and list2
; which are assumed to be of equal length
(check-expect (andmap2 adds-to-10 (list 1 5 9) (list 9 5 1)) #true)
(check-expect (andmap2 adds-to-10 (list 1 5 9) (list 9 6 1)) #false)
(define (andmap2 f list1 list2)
  (cond
    [(empty? list1) #true]
    [else
     (and
      (f (first list1) (first list2))
      (andmap2 f (rest list1) (rest list2)))]))

(define (adds-to-10 x y)
  (equal? (+ x y) 10))