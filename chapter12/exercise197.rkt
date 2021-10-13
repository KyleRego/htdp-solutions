;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise197) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

(define-struct lc [let num])
; A Letter-Count is a structure:
;     (make lc Letter Number)
; interpretation: (make lc let num) represents
; a letter associated with a count related to that letter

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

; exercise 196

; Dictionary -> List-of-Letter-Counts
; returns a list of Letter-Counts based
; on the dictionary by counting how many words
; start with each letter
(check-expect (count-by-letter testdic1 LETTERS)
              (list (make-lc "a" 0)
                    (make-lc "b" 0)
                    (make-lc "c" 0)
                    (make-lc "d" 0)
                    (make-lc "e" 0)
                    (make-lc "f" 0)
                    (make-lc "g" 0)
                    (make-lc "h" 1)
                    (make-lc "i" 0)
                    (make-lc "j" 0)
                    (make-lc "k" 0)
                    (make-lc "l" 0)
                    (make-lc "m" 0)
                    (make-lc "n" 0)
                    (make-lc "o" 0)
                    (make-lc "p" 0)
                    (make-lc "q" 0)
                    (make-lc "r" 0)
                    (make-lc "s" 0)
                    (make-lc "t" 0)
                    (make-lc "u" 0)
                    (make-lc "v" 0)
                    (make-lc "w" 1)
                    (make-lc "x" 0)
                    (make-lc "y" 0)
                    (make-lc "z" 0)))
                    
(define (count-by-letter dic letters)
  (cond
    [(= (length letters) 1) (list (make-lc
                             (first letters)
                             (starts-with# (first letters) dic)))]
    [else (cons (make-lc
                 (first letters)
                 (starts-with# (first letters) dic))
                (count-by-letter dic (rest letters)))]))

; exercise 197

; Dictionary -> Letter-Count
; consumes a dictionary and produces a letter count
; for the letter that occurs most often as the first
; in the given dictionary
(check-expect (most-frequent testdic2) (make-lc "b" 2))
(define (most-frequent dic)
  (first (sort-lc (count-by-letter dic LETTERS))))

; List-of-LCs -> List-of-LCs
; sorts the list of LCs into descending order based on count
(define (sort-lc lcs)
  (cond
    [(empty? lcs) '()]
    [else (insert-lc (first lcs) (sort-lc (rest lcs)))]))

; LC List-of-LCs -> List-of-LCs
; inserts the LC into the sorted list
; to keep it in descending order
(define (insert-lc lc lcs)
  (cond
    [(empty? lcs) (list lc)]
    [else (if (>lc lc (first lcs))
              (cons lc lcs)
              (cons (first lcs) (insert-lc lc (rest lcs))))]))

; LC LC -> Boolean
; determines if the count of the first LC
; is greater than the count of the second
(define (>lc lc1 lc2)
  (> (lc-num lc1) (lc-num lc2)))


(most-frequent AS-LIST) ; s is the letter with the most words