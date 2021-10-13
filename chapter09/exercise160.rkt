;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise160) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A Son.L is one of: 
; – empty 
; – (cons Number Son.L)
; 
; Son is used when it 
; applies to Son.L and Son.R

; Son.L Number -> Son.L
; adds a num to given set
(check-expect (set+.L
               7
               (cons 7 '()))
              (cons 7 (cons 7 '())))
(define (set+.L num set)
  (cons num set))
  

; A Son.R is one of: 
; – empty 
; – (cons Number Son.R)
; 
; Constraint If s is a Son.R, 
; no number occurs twice in s
(check-expect (set+.R 7 (cons 7 '()))
              (cons 7 '()))
(check-expect (set+.R 8 (cons 7 '()))
              (cons 8 (cons 7 '())))
(define (set+.R num set)
  (cond
    [(member? num set) set]
    [else (cons num set)]))