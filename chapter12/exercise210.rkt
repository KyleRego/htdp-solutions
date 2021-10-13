;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise210) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 209

; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; String -> Word
; converts s to the chosen word representation
(check-expect (string->word "cat") (list "c" "a" "t"))
(define (string->word s)
  (explode s))
 
; Word -> String
; converts w to a string
(check-expect (word->string (list "c" "a" "t")) "cat")
(define (word->string w)
  (implode w))

; exercise 210
; List-of-words -> List-of-strings
; turns all Words in low into Strings
(check-expect (words->strings '()) '())
(check-expect (words->strings (list
                               (list "c" "a" "t")
                               (list "r" "a" "t")))
              (list "cat" "rat"))
(define (words->strings low)
  (cond
    [(empty? low) '()]
    [else (cons (word->string (first low)) (words->strings (rest low)))]))
