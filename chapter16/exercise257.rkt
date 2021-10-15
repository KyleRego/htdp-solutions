;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise257) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 257

; [X] N [N -> X] -> [List-of X]
; constructs a list by applying f to 0, 1, ..., (sub1 n)
; (build-list n f) == (list (f 0) ... (f (- n 1)))
(check-expect (build-l*st 3 add1) (list 1 2 3))
(define (build-l*st n f)
  (cond
    [(= n 1) (list (f 0))]
    [else (add-to-end (f (- n 1))
                (build-l*st (- n 1) f))]))


(define (add-to-end psn p)
  (cond
    [(empty? (rest p)) (list (first p) psn)]
    [else (cons (first p) (add-to-end psn (rest p)))]))

