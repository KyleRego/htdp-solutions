;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise212) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 212

; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; A List-of-Words is one of:
; - '()
; - (cons Word List-of-Words)
; interpretation a List-of-Words is a list of lists of 1Strings

(define word1 (list "c" "a" "t"))
(define word2 (list "r" "a" "t"))
(define word3 (list "b" "a" "t"))
(define word4 (list "h" "e" "l" "l" "o"))
(define word5 (list "w" "o" "r" "l" "d"))

(define alow1 (list word1 word2 word3))
(define alow2 (list word4 word5))