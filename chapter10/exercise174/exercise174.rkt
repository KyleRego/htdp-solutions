;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise174) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 174

(require 2htdp/batch-io)

; An LN is one of: 
; – '()
; – (cons Los LN)
; interpretation a list of lines, each is a list of Strings

; LN -> String
; converts a list of lines (lists of strings)
; into a string where strings are separated by blank spaces
; and lines are separated by newlines
(define (collapse ln)
  (cond
    [(empty? ln) ""]
    [else (if (not (= (length (rest ln)) 0))
              (string-append (collapse-line (first ln)) "\n" (collapse (rest ln)))
              (collapse-line (first ln)))]))

; List-of-strings -> String
; returns a string representing the list of strings
; where all the strings from the list are separated
; by a space
(define (collapse-line line)
  (cond
    [(empty? line) ""]
    [else (if (not (= (length (rest line)) 0))
              (string-append (first line) " " (collapse-line (rest line)))
              (first line))]))

; 1String -> String
; converts the given 1String to a 3-letter numeric String
 
(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t")
              (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a")
              (string-append "0" (code1 "a")))
 
(define (encode-letter s)
  (cond
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10)
     (string-append "00" (code1 s))]
    [(< (string->int s) 100)
     (string-append "0" (code1 s))]))
 
; 1String -> String
; converts the given 1String into a String
 
(check-expect (code1 "z") "122")
 
(define (code1 c)
  (number->string (string->int c)))

; String -> String
; converts the given string to a numeric string
; according to the encode-letter fn
(check-expect (encode-word "ab") (string-append (encode-letter "a") (encode-letter "b")))
(define (encode-word word)
  (cond
    [(string=? word "") ""]
    [else (encode-wordx (explode word))]))

; List-of-1strings -> String
; converts a list of 1Strings to a String
; according to the encode-letter function
(check-expect (encode-wordx (cons "a" (cons "b" '())))
                            (string-append (encode-letter "a") (encode-letter "b")))
(define (encode-wordx alos)
  (cond
    [(empty? alos) ""]
    [else (string-append (encode-letter (first alos)) (encode-wordx (rest alos)))]))

; List-of-strings -> List-of-strings
; converts each string into an encoded string
; according to the encode-word function
(define (encode-list alos)
  (cond
    [(empty? alos) '()]
    [else (cons (encode-word (first alos)) (encode-list (rest alos)))]))

; List-of-list-of-strings -> List-of-list-of-strings
; Replaces every string into an encoded string
; accoding to the encode-list function
(define (encode-list-list alol)
  (cond
    [(empty? alol) '()]
    [else (cons (encode-list (first alol)) (encode-list-list (rest alol)))]))

(write-file "encoded.txt"
            (collapse (encode-list-list (read-words/line "test.txt"))))