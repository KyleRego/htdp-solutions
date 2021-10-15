;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise273) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 273

; [X Y] [X->Y] [List-of X] -> [List-of Y]
(check-expect (map add-one (list 1 2 3))
              (map-from-fold add-one (list 1 2 3)))
(check-expect (map-from-fold add-one (list 5)) (list 6))
(define (map-from-fold g l)
  (local (; X Y -> Y
          (define (f x y)
           (g x)))
  (cond
    [(empty? l) '()]
    [else
     (cons (foldr f (first l) l) (map-from-fold g (rest l)))])))




(define (add-one num)
  (+ 1 num))