;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise252) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 252

; fold1 from exercise251 appears to be sufficient to abstract
; the two functions here as well

(require 2htdp/image)

(define (fold1 l accumulator initval)
  (cond
    [(empty? l) initval]
    [else
     (accumulator (first l)
                  (fold1 (rest l)
                         accumulator
                         initval))]))

(check-expect (product '(1 2 3 4)) 24)
(define (product l)
  (fold1 l * 1))

; Posn Image -> Image 
(define (place-dot p img)
  (place-image
     dot
     (posn-x p) (posn-y p)
     img))
 
; graphical constants:    
(define emt
  (empty-scene 100 100))
(define dot
  (circle 3 "solid" "red"))

(define (image* l)
  (fold1 l place-dot emt))

; [List-of Posn] -> Image
(define (image*orig l)
  (cond
    [(empty? l) emt]
    [else
     (place-dot
      (first l)
      (image* (rest l)))]))

(check-expect (image*orig (list (make-posn 5 5))) (image* (list (make-posn 5 5))))

(check-expect (image*orig (list
                           (make-posn 5 5)
                           (make-posn 6 6)
                           ))
              (image* (list
                       (make-posn 5 5)
                       (make-posn 6 6))))