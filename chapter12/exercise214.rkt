;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise214) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 214 (putting everything together)

(require 2htdp/batch-io)

; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines "words.txt"))

; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; String -> List-of-strings
; finds all words that the letters of some given word spell
 
(check-member-of (alternative-words "cat")
                 (list "act" "cat")
                 (list "cat" "act"))
 
(check-satisfied (alternative-words "rat")
                 all-words-from-rat?)
 
(define (alternative-words s)
  (in-dictionary
    (words->strings (arrangements (string->word s)))))


; Word -> List-of-words
; finds all rearrangements of word
(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else (insert-everywhere/in-all-words (first w)
            (arrangements (rest w)))]))

; exercise 209

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

; List-of-strings -> Boolean
(define (all-words-from-rat? w)
  (and
    (member? "rat" w) (member? "art" w) (member? "tar" w)))
 
 
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

; 1String List-of-Words -> List-of-Words
; inserts the letter let into the beginning,
; end, and everywhere inbetween, into every word
; to make a new list of words
(check-expect (insert-everywhere/in-all-words "a" '()) '())
(check-member-of
 (insert-everywhere/in-all-words "a" (list (list "b" "c")))
 (list (list "a" "b" "c") (list "b" "a" "c") (list "b" "c" "a"))
 (list (list "b" "c" "a") (list "a" "b" "c") (list "b" "a" "c"))
 (list (list "b" "a" "c") (list "b" "c" "a") (list "a" "b" "c"))
 (list (list "b" "a" "c") (list "a" "b" "c") (list "b" "c" "a"))
 (list (list "b" "c" "a") (list "b" "a" "c") (list "a" "b" "c"))
 (list (list "a" "b" "c") (list "b" "c" "a") (list "b" "a" "c")))
 
(define (insert-everywhere/in-all-words let words)
  (cond
    [(empty? words) '()]
    [else (append (insert-everywhere let (first words))
                (insert-everywhere/in-all-words let (rest words)))]))

; 1String Word -> List-of-Words
; inserts the letter let into the word at the beginning,end
; and everywhere inbetween to produce a list of words
(check-expect (insert-everywhere "a" '()) (list (list "a")))
(define (insert-everywhere let word)
  (cond
    [(empty? word) (list (list let))]
    [else (cons
           (prepend let word)
           (prepend-all (first word) (insert-everywhere let (rest word))))]))

; 1String Word -> Word
; inserts the letter at the beginning of the word
(check-expect (prepend "a" (list "b")) (list "a" "b"))
(define (prepend let word)
  (append (list let) word))

; 1String List-of-words -> List-of-words
; inserts the letter at the beginning of every word in the list
; making a new list of words
(check-expect (prepend-all "a" (list
                                (list "a")
                                (list "b")))
              (list
               (list "a" "a")
               (list "a" "b")))
(define (prepend-all let words)
  (cond
    [(empty? (rest words)) (list (prepend let (first words)))]
    [else (cons (prepend let (first words))
                (prepend-all let (rest words)))]))



(alternative-words "ate")