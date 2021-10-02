;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise187) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 187

(define-struct gp [name score])
; A GamePlayer is a structure: 
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who 
; scored a maximum of s points
; A GamePlayer is also referred to as GP

; A List-of-GPs is one of:
; - '()
; - (cons GP List-of-GPs)

; List-of-GPs -> List-of-GPs
; sorts the list of GPs by score, descending order
(check-expect (sort-gp '()) '())
(check-expect (sort-gp (list (make-gp "Kyle" 10)))
              (list (make-gp "Kyle" 10)))
(check-expect (sort-gp (list (make-gp "Kyle" 10) (make-gp "Ryan" 15)))
              (list (make-gp "Ryan" 15) (make-gp "Kyle" 10)))
(check-expect (sort-gp (list (make-gp "Kyle" 10) (make-gp "Ryan" 15) (make-gp "Noah" 8)))
              (list (make-gp "Ryan" 15) (make-gp "Kyle" 10) (make-gp "Noah" 8)))

(define (sort-gp alop)
  (cond
    [(empty? alop) '()]
    [else (insert-gp (first alop) (sort-gp (rest alop)))]))

; GP List-of-GPs -> List-of-GPs
; inserts a GP into a List-of-GPs where the GP belongs
; to make the list have a descending order by player score
(define (insert-gp gp alop)
  (cond
    [(empty? alop) (list gp)]
    [else
     (cond
       [(gp>? gp (first alop)) (cons gp alop)]
       [else (cons (first alop) (insert-gp gp (rest alop)))])]))

; GP GP -> Boolean
; compares two GP and returns true
; if the first has a greater score than the second
(define (gp>? gp1 gp2)
  (> (gp-score gp1) (gp-score gp2)))
