;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise395) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 395

; [List-of Any] Number -> [List-of Any]
; produces the first n items of l
; or all of l if n is greater than l's length
(check-expect (take '(1 2 3) 4) '(1 2 3))
(check-expect (take '(1 2 3) 2) '(1 2))
(define (take l n)
  (cond
    [(empty? l) '()]
    [(= n 0) '()]
    [(> n (length l)) l]
    [else (cons (first l) (take (rest l) (- n 1)))]))

; [List-of Any] Number -> [List-of Any]
; removes the first n items from l or '()
; if l is length less than n
(check-expect (drop '(1 2 3 4) 2) '(3 4))
(check-expect (drop '(1 2 3 4) 5) '())
(define (drop l n)
  (cond
    [(= n 0) l]
    [(> n (length l)) '()]
    [else
     (drop (rest l) (- n 1))]))