;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise331) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 331

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


; Dir -> Number
; determines how many files in a directory
(check-expect (how-many figure123) 7)
(define (how-many dir)
  (cond
    [(empty? dir) 0]
    [(string? (first dir)) (+ 1 (how-many (rest dir)))]
    [(cons? (first dir)) (+ (how-many (first dir))
                            (how-many (rest dir)))]))