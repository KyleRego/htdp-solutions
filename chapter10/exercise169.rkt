;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise169) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 169

; a List-of-Posns is one of:
; - '()
; (cons Posn list-of-Posns)

; List-of-Posns -> List-of-Posns
; returns a list of all posns with
; 0 < x < 100 and 0 < y < 200
(check-expect (legal '()) '())
(check-expect (legal (cons (make-posn 50 50) '()))
              (cons (make-posn 50 50) '()))
(check-expect (legal (cons (make-posn -25 50) '())) '())
(check-expect (legal (cons (make-posn 25 250) '())) '())
(check-expect (legal (cons (make-posn 125 50) '())) '())
(check-expect (legal (cons (make-posn 25 -50) '())) '())
(check-expect (legal (cons (make-posn -25 250) '())) '())
(check-expect (legal (cons (make-posn 50 50)
                           (cons (make-posn 75 75) '())))
              (cons (make-posn 50 50)
                    (cons (make-posn 75 75) '())))
(define (legal alop)
  (cond
    [(empty? alop) '()]
    [else (if (legal1 (first alop))
           (cons (first alop) (legal (rest alop)))
           (legal (rest alop)))]))

(define (legal1 p)
  (and
   (> (posn-x p) 0)
   (< (posn-x p) 100)
   (> (posn-y p) 0)
   (< (posn-y p) 200)))