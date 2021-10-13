;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise78) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 78


; a 3-Letter-Word is a structure
;     (make-3-letter-word 1String 1String 1String)
; interpretation: represents a three letter word
; consisting of the three 1Strings let1, let2, let3
(define-struct 3-letter-word [let1 let2 let3])