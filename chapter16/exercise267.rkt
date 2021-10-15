;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise267) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 267

; [List-of Number] -> [List-of Number]
; converts a list of US$ amounts to euro
; based on exchange rate of $1.06 = 1 euro
(check-expect (convert-euro (list 1.06)) (list 1))
(define (convert-euro alon)
  (local (
           ; Number -> Number
           ; convert a dollar amount to euros
           (define (convert-to-euro dollar)
             (/ dollar 1.06)))
  (map convert-to-euro alon)))

; skip convertFC

; [List-of Posn] -> [List-of [List-of Number]]
; makes a list of posns into a list of lists
; where each list is a pair of numbers
(check-expect (translate (list (make-posn 5 5))) (list (list 5 5)))
(define (translate alon)
  (local (; Posn -> [List-of Number]
          ; converts a posn to a list
          ; which is a pair of numbers
          (define (convert-to-pair pos)
            (list (posn-x pos) (posn-y pos)))
  (map convert-to-pair alon))




