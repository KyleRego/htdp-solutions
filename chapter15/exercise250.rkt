;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise250) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 250

; Number Function -> [List-of Number]
(define (tabulate n function)
  (cond
    [(= n 0) (list (function 0))]
    [else
     (cons
      (function n)
      (tabulate (sub1 n) function))]))

; Number -> [List-of Number]
; tabulates sqrt between n and 0 in a list
(check-expect (tab-sqrt 1) '(1 0))
(define (tab-sqrt n)
  (tabulate n sqrt))

; Number -> [List-of Number]
; tabulates tan between n and 0 in a list
(define (tab-tan n)
  (tabulate n tan))
  