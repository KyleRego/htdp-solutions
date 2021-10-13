;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise198) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 198

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

; A Dictionary is a List-of-strings.

; List-of-Letters Dictionary -> List-of-Dictionarys
; produces a list of Dictionarys, one per letter
(check-expect (words-by-first-letter* '() (list "apple")) '())
(check-expect (words-by-first-letter* (list "a") '()) (list '()))
(check-expect (words-by-first-letter* (list "a") (list "a" "apple" "hello"))
              (list (list "a" "apple")))
(check-expect (words-by-first-letter* (list "a" "b") (list "apple" "bear"))
              (list (list "apple") (list "bear")))
(define (words-by-first-letter* letters dic)
  (cond
    [(empty? letters) '()]
    [(empty? (rest letters))
             (list (list-by-first-letter (first letters) dic))]
    [else
     (cons (list-by-first-letter (first letters) dic)
           (words-by-first-letter* (rest letters) dic))]))


; Letter Dictionary -> Dictionary
; consumes a dictionary and letter
; and returns a dictionary of all words that
; began with that letter in the given dictionary
(check-expect (list-by-first-letter "a" '()) '())
(define (list-by-first-letter letter dic)
  (cond
    [(empty? dic) '()]
    [else (if (string=?
               (first-1str (first dic))
               letter)
              (cons (first dic) (list-by-first-letter letter (rest dic)))
              (list-by-first-letter letter (rest dic)))]))


; String -> 1String
; returns the first character of the string
(check-expect (first-1str "hello world") "h")
(define (first-1str str)
  (substring str 0 1))
  