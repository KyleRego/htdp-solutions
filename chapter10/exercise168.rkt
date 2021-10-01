;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise168) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 168

; a List-of-Posns is one of:
; - '()
; (cons Posn list-of-Posns)

; List-of-Posns -> List-of-Posns
; increases the y coordinate of each posn
; in the list by 1
(check-expect (translate (cons (make-posn 2 4) '()))
              (cons (make-posn 2 5) '()))
(check-expect (translate (cons (make-posn 2 4)
                               (cons (make-posn 7 9) '())))
              (cons (make-posn 2 5)
                    (cons (make-posn 7 10) '())))
(define (translate alop)
  (cond
    [(empty? alop) '()]
    [else (cons (translate1 (first alop)) (translate (rest alop)))]))

; posn -> posn
; increases the y coordinate of given posn by 1
(define (translate1 p)
  (make-posn (posn-x p) (+ 1 (posn-y p))))