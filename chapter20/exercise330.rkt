;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise330) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 330

; A Dir (short for directory) is one of: 
; – '()
; – (cons File Dir)
; – (cons Dir Dir)
 
; A File is a String.

(define figure123 (list
                   (list
                    "part1"
                    "part2"
                    "part3")
                   "read!"
                   (list
                    (list
                     "hang"
                     "draw")
                    (list
                     "read!"))))