;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise211) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 209

(require 2htdp/batch-io)

; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines "words.txt"))

; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; String -> Word
; converts s to the chosen word representation
(check-expect (string->word "cat") (list "c" "a" "t"))
(define (string->word s)
  (explode s))
 
; Word -> String
; converts w to a string
(check-expect (word->string (list "c" "a" "t")) "cat")
(define (word->string w)
  (implode w))

; exercise 210
; List-of-words -> List-of-strings
; turns all Words in low into Strings
(check-expect (words->strings '()) '())
(check-expect (words->strings (list
                               (list "c" "a" "t")
                               (list "r" "a" "t")))
              (list "cat" "rat"))
(define (words->strings low)
  (cond
    [(empty? low) '()]
    [else (cons (word->string (first low)) (words->strings (rest low)))]))

; exercise 211

; List-of-strings -> List-of-strings
; picks out all those Strings that occur in the dictionary 
(define (in-dictionary los)
  (in-dictionary* los AS-LIST))


; List-of-strings List-of-strings -> List-of-strings
; picks out all those Strings that occur in given dictionary
(check-expect (in-dictionary* '() (list "cat")) '())
(check-expect (in-dictionary*
               (list "rat" "cat" "at" "bat")
               (list "cat" "bat"))
              (list "cat" "bat"))
(define (in-dictionary* los dic)
  (cond
    [(empty? los) '()]
    [else (if
           (member? (first los) dic)
           (cons (first los) (in-dictionary* (rest los) dic))
           (in-dictionary* (rest los) dic))]))

