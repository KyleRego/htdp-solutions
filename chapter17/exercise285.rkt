;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise285) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 285

; [List-of Number] -> [List-of Number]
; converts a list of us dollar amounts
; to a list of euro amounts
; saying that 1.06$ = 1 euro
(check-expect (convert-euro (list 1.06)) (list 1))
(define (convert-euro alon)
  (map (lambda (num) (/ num 1.06)) alon))

; [List-of Posn] -> [List-of [List-of Number]]
; converts a list of Posns into a list of lists
; of pairs of numbers
(check-expect (translate (list (make-posn 5 5))) (list (list 5 5)))
(define (translate alop)
  (map (lambda (pos) (list (posn-x pos) (posn-y pos)))
       alop))