;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 1
(define x 3)
(define y 4)

(sqrt (+ (sqr x) (sqr y)))

; exercise 2
(define prefix "hello")
(define suffix "world")

(string-append prefix "_" suffix)

; exercise 3
(define str "helloworld")
(define i 5)

(string-append (substring str 0 i) "_" (substring str i))





