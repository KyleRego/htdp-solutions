;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise291) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 291

; [X Y] [X -> Y] [List-of X] -> [List-of Y]
(check-expect (map-via-fold add3 (list 1 2 3 4)) (list 4 5 6 7))
(define (map-via-fold g l)
  (cond
    [(empty? l) '()]
    [else
     (cons
      (foldr (lambda (x y) (g x)) (first l) l) (map-via-fold g (rest l)))]))


(define (add3 num)
  (+ 3 num))