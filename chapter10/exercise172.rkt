;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise172) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 172

; An LN is one of: 
; – '()
; – (cons Los LN)
; interpretation a list of lines, each is a list of Strings

; LN -> String
; converts a list of lines (lists of strings)
; into a string where strings are separated by blank spaces
; and lines are separated by newlines

(define line1 (cons "hello" (cons "world" '())))
(define line2 (cons "hello" (cons "there" '())))
(define ln1 (cons line1 (cons line2 '())))

(check-expect (collapse '()) "")
(check-expect (collapse ln1) "hello world\nhello there")
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
  