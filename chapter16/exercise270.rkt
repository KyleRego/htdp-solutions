;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise270) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 270

; Number -> [List-of Number]
; creates the list (list 0 ... (- n 1))
; for any natural number n
(check-expect (build1 4) (list 0 1 2 3))
(define (build1 n)
  (local ((define (helper n)
            n))
  (build-list n helper)))

; Number -> [List-of Number]
; creates the list (list 1 ... n)
; for any natural number n
(check-expect (build2 4) (list 1 2 3 4))
(define (build2 n)
  (local ((define (helper n)
            (+ 1 n)))
  (build-list n helper)))

; Number -> [List-of Number]
; creates the list (list 1 1/2 ... 1/n)
; for any natural number n
(check-expect (build3 4) (list 1 1/2 1/3 1/4))
(define (build3 n)
  (local ((define (helper n)
            (/ 1 (+ 1 n))))
  (build-list n helper)))

; Number -> [List-of Number]
; creates the list (list 1 ... n)
; for any natural number n
(check-expect (build4 4) (list 0 2 4 6))
(define (build4 n)
  (local ((define (helper n)
            (* 2 n)))
  (build-list n helper)))