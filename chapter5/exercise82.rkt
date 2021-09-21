;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise82) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 82

; a 3LW is a structure
;     (make-3lw 1String 1String 1String)
; interpretation (make-3lw let1 let2 let3)
; represents the three letter word consisting
; of the three letters let1, let2, and let3
(define-struct 3lw [let1 let2 let3])

; 3LW 3LW -> 3LW
; consumes two three-letter words
; and returns a three letter word with
; #false where the letters disagree, and the
; letter where the two words have the same letter
(check-expect (compare-word (make-3lw "a" "b" "c") (make-3lw "a" "b" "c")) (make-3lw "a" "b" "c"))
(check-expect (compare-word (make-3lw "a" "b" "c") (make-3lw "d" "e" "f")) (make-3lw #false #false #false))
(check-expect (compare-word (make-3lw "a" "b" "c") (make-3lw "a" "d" "c")) (make-3lw "a" #false "c"))
(define (compare-word word1 word2)
  (make-3lw (cond
              [(string=? (3lw-let1 word1) (3lw-let1 word2)) (3lw-let1 word1)]
              [else #false])
            (cond
              [(string=? (3lw-let2 word1) (3lw-let2 word2)) (3lw-let2 word1)]
              [else #false])
            (cond
              [(string=? (3lw-let3 word1) (3lw-let3 word2)) (3lw-let3 word1)]
              [else #false])))