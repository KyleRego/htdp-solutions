;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise295) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 295

; distances in terms of pixels 
(define WIDTH 300)
(define HEIGHT 300)
 
; N -> [List-of Posn]
; generates n random Posns in [0,WIDTH) by [0,HEIGHT)
(check-satisfied (random-posns 3)
                 (n-inside-playground? 3))
(define (random-posns n)
  (build-list
    n
    (lambda (i)
      (make-posn (random WIDTH) (random HEIGHT)))))


; N -> [[List-of Posn] -> Boolean]
; produces a predicate that determines
; whether alop is size n and all its
; elements are within a WIDTH by HEIGHT rectangle
(define (n-inside-playground? n)
  (lambda (alop)
    (and
     (= (length alop) n)
     (within-playground (first alop))
     (within-playground-all (rest alop)))))

(define (within-playground pos)
  (local (
          (define x (posn-x pos))
          (define y (posn-y pos)))
    (and
     (<= 0 x)
     (< x WIDTH)
     (<= 0 y)
     (< y HEIGHT))))

(define (within-playground-all alop)
  (cond
    [(empty? alop) #true]
    [else
     (and
      (within-playground (first alop))
      (within-playground-all (rest alop)))]))
    