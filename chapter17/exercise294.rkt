;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise294) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; [X] X [List-of X] -> [Maybe N]
; determine the index of the first occurrence
; of x in l, #false otherwise
(define (index x l)
  (cond
    [(empty? l) #false]
    [else (if (equal? (first l) x)
              0
              (local ((define i (index x (rest l))))
                (if (boolean? i) i (+ i 1))))]))

; [X] X [List-of X] -> [[Maybe N] -> Boolean]
; produces a predicate that, if given n
; determines whether nth position of a-list is x
; and if given false, determines that x is not in a-list
(define (is-index? x a-list)
  (lambda (n)
    (cond
      [(false? n) (not (member? x a-list))]
      [else
       (equal? (ith-of-list n a-list) x)])))

; Number [List-of X] -> [Maybe X]
; produces the ith element of l
(check-expect (ith-of-list 4 '(1 2 3 4 5)) 5)
(check-expect (ith-of-list 7 '(1)) #false)
(define (ith-of-list i l)
  (cond
    [(empty? l) #false]
    [(= i 0) (first l)]
    [else (ith-of-list (- i 1) (rest l))]))


(check-satisfied (index 1 '{2 3 4}) (is-index? 1 '(2 3 4)))
(check-satisfied (index 1 '(2 3 4 5 1)) (is-index? 1 '(2 3 4 5 1)))