;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise428) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 428

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
(check-expect (quick-sort< (list 11 11 8 14 7)) (list 7 8 11 11 14))
(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [(= 1 (length alon)) alon]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (smallers alon pivot))
                    (equal alon pivot)
                    (quick-sort< (largers alon pivot))))]))

; [List-of Number] Number -> [List-of Number]
; produces a new list of all numbers in alon equal to n
(define (equal alon n)
  (filter (lambda (x) (= x n)) alon))

; [List-of Number] Number -> [List-of Number]
; produces a new list of all numbers in alon larger than n
(check-expect (largers (list 1 3 3 4 4 5) 2)
              (list 3 3 4 4 5))
(define (largers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (> (first alon) n)
              (cons (first alon) (largers (rest alon) n))
              (largers (rest alon) n))]))
 
; [List-of Number] Number -> [List-of Number]
; produces a new list of all numbers in alon smaller than n
(check-expect (smallers (list 1 1 2 6) 3)
              (list 1 1 2))
(define (smallers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (< (first alon) n)
              (cons (first alon) (smallers (rest alon) n))
              (smallers (rest alon) n))]))