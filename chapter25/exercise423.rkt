;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise423) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 423

; [List-of Any] N -> [List-of [List-of Any]]
; breaks a list into a list of lists of size n
(check-expect (list->chunks
               (list "a" "b" "c") 1)
              (list (list "a") (list "b") (list "c")))
(check-expect (list->chunks
               (list "a" "b" "c") 2)
              (list (list "a" "b") (list "c")))
(check-expect (list->chunks
               (list 1 2 3 4 5 6) 2)
              (list (list 1 2) (list 3 4) (list 5 6)))
(define (list->chunks aloa n)
  (cond
    [(empty? aloa) '()]
    [else (cons
           (take aloa n)
           (list->chunks (drop aloa n) n))]))

; [List-of Any] N -> [List-of Any]
; returns a list of the first n items of aloa
(check-expect (take (list "a" 1 2) 2) (list "a" 1))
(define (take aloa n)
  (cond
    [(empty? aloa) '()]
    [(= n 0) '()]
    [else (cons (first aloa)
                (take (rest aloa) (- n 1)))]))

; [List-of Any] N -> [List-of Any]
; returns a list with the first n items of aloa dropped
(check-expect (drop (list "a" 1 2) 1) (list 1 2))
(define (drop aloa n)
  (cond
    [(empty? aloa) '()]
    [(= n 0) aloa]
    [else (drop (rest aloa) (- n 1))]))

; String Number -> [List-of String]
; produces a list of string chunks of size n
(check-expect (partition "hello world" 2) (list "he" "ll" "o " "wo" "rl" "d"))
(define (partition str n)
  (map implode (list->chunks (explode str) n)))
