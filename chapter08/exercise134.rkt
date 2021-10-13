;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise134) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 134

; A List-of-strings is one of:
; - '()
; - (cons String List-of-strings)

; String List-of-strings -> Boolean
; determines if a string appears in a
; list of strings
(check-expect (contains? "red" '()) #false)
(check-expect (contains? "green" (cons "red" '())) #false)
(check-expect (contains? "a" (cons "b" (cons "c" (cons "a" '())))) #true)
(define (contains? str alos)
  (cond
    [(empty? alos) #false]
    [(cons? alos)
     (cond
       [(string=? (first alos) str) #true]
       [else (contains? str (rest alos))])]))

