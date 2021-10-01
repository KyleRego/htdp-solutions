;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise163) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 163

; a List-of-numbers is one of:
; - '()
; - (cons Number List-of-numbers)

; List-of-numbers -> List-of-numbers
; converts a list of temperatures in Fahrenheit
; to a list of temperatures in Celsius
(check-expect (convertFC '()) '())
(check-expect (convertFC (cons 32 '())) (cons 0 '()))
(check-expect (convertFC (cons 32 (cons 68 '())))
             (cons 0 (cons 20 '())))
(define (convertFC F)
  (cond
    [(empty? F) '()]
    [else (cons (* 5/9 (- (first F) 32)) (convertFC (rest F)))]))