;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise155) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 155

(define-struct layer [color doll])
; An RD (short for Russian doll) is one of: 
; – String 
; – (make-layer String RD)

; RD -> String
; consumes a russian doll and produces the innermost color
(check-expect (inner "red") "red")
(check-expect (inner (make-layer "blue" "red")) "red")
(check-expect (inner (make-layer "green"
                          (make-layer "red" "blue"))) "blue")
(define (inner rd)
  (cond
    [(string? rd) rd]
    [else (inner (layer-doll rd))]))