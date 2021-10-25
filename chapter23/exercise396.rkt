;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise396) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 396

; String HM-Word 1String -> HM-Word
; compares the one-letter guess to the
; word to determine how the HM-Word changes
(check-expect (compare-word "cat" (list "_" "_" "_") "g")
              (list "_" "_" "_"))
(check-expect (compare-word "cat" (list "_" "_" "_") "t")
              (list "_" "_" "t"))
(define (compare-word the-word current-status ke)
  (local ((define the-word1 (explode the-word)))
    (cond
      [(empty? the-word1) '()]
      [(string=? (first the-word1) ke)
       (cons ke (compare-word (implode (rest the-word1)) (rest current-status) ke))]
      [else (cons "_" (compare-word (implode (rest the-word1)) (rest current-status) ke))])))