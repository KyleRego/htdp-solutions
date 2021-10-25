;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise393) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 393

; A Son.L is one of: 
; – empty 
; – (cons Number Son.L)

; Son.L Son.L -> Son.L
; produces a new set that contains all
; the elements of the two given sets
(check-expect (union '(a b) '(c d)) '(a b c d))
(define (union set1 set2)
  (append set1 set2))

; Son.L Son.L -> Son.L
; produces a new set that contains all
; elements that occur in both given sets
; (allows the resulting set to contain duplicates
; consistent with the data definition of Son.L)
(check-expect (intersect '(a b) '(b c)) '(b))
(define (intersect set1 set2)
  (cond
    [(empty? set1) '()]
    [(empty? set2) '()]
    [(member? (first set1) set2)
     (cons (first set1) (intersect (rest set1) set2))]
    [else (intersect (rest set1) set2)]))
