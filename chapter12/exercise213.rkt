;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise213) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 213

; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; A List-of-Words is one of:
; - '()
; - (cons Word List-of-Words)
; interpretation a List-of-Words is a list of lists of 1Strings

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