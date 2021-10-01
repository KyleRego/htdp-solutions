;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise173) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 173

(require 2htdp/batch-io)

(define line1 (cons "hello"
                    (cons "the"
                          (cons "world" '()))))
(define line2 (cons "hello"
                    (cons "an"
                          (cons "world" '()))))
(define line3 (cons "hello"
                    (cons "a"
                          (cons "world" '()))))
(define ln (cons line1
                 (cons line2
                       (cons line3 '()))))

; An LN is one of: 
; – '()
; – (cons Los LN)
; interpretation a list of lines, each is a list of Strings

; LN -> String
; converts a list of lines (lists of strings)
; into a string where strings are separated by blank spaces
; and lines are separated by newlines

(define line4 (cons "hello" (cons "world" '())))
(define line5 (cons "hello" (cons "there" '())))
(define ln1 (cons line4 (cons line5 '())))

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

; LN -> LN
; removes all articles ("a" "an" "the") from the LN
(check-expect (rm-articles '()) '())
(check-expect (rm-articles ln)
              (cons (cons "hello" (cons "world" '()))
                    (cons (cons "hello" (cons "world" '()))
                          (cons (cons "hello" (cons "world" '())) '()))))
(define (rm-articles alol)
  (cond
    [(empty? alol) '()]
    [else (cons (rm-article (first alol)) (rm-articles (rest alol)))]))

; List-of-strings -> List-of-strings
; remove all articles from the list
(define (rm-article line)
  (cond
    [(empty? line) '()]
    [else (if (or
             (string=? (first line) "an")
             (string=? (first line) "a")
             (string=? (first line) "the"))
        (rm-article (rest line))
        (cons (first line) (rm-article (rest line))))]))

(define (run file-name)
  (write-file (string-append "no-articles-" file-name)
              (collapse (rm-articles (read-words/line file-name)))))

(run "test.txt")
  
  