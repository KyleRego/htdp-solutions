;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise235) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 235

; String Los -> Boolean
; determines whether l contains the string s
(define (contains? s l)
  (cond
    [(empty? l) #false]
    [else (or (string=? (first l) s)
              (contains? s (rest l)))]))

(check-expect (contains-atom? '("apple" "banana" "pear")) #false)
(check-expect (contains-atom? '("apple" "banana" "atom")) #true)
(define (contains-atom? l)
  (contains? "atom" l))

(define (contains-basic? l)
  (contains? "basic" l))

(define (contains-zoo? l)
  (contains? "zoo" l))