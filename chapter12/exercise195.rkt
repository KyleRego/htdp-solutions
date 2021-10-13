;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise195) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/batch-io)

; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines "words.txt"))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

(define testdic1 (list "hello" "world"))
(define testdic2 (list "foo" "bar" "baz"))
(define testdic3 (list "a" "apple" "pear" "banana" "peanut"))

; exercise 195

; Letter Dictionary -> Number
; counts how many words in the dictionary
; start with the given letter
(check-expect (starts-with# "h" testdic1) 1)
(check-expect (starts-with# "b" testdic2) 2)
(check-expect (starts-with# "a" testdic3) 2)
(check-expect (starts-with# "b" testdic3) 1)
(define (starts-with# let dic)
  (cond
    [(empty? dic) 0]
    [else (if
           (starts-with-let let (first dic))
           (+ 1 (starts-with# let (rest dic)))
           (starts-with# let (rest dic)))]))

; Letter String -> Boolean
; determines whether the string starts with
; the given letter
(define (starts-with-let let str)
  (string=? let (substring str 0 1)))

(starts-with# "e" AS-LIST)
(starts-with# "z" AS-LIST)