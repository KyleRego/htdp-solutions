;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise146) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 146

; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures

; NEList-of-temperatures -> Number
; returns the number of temperatures in the NEList-of-temperatures
(check-expect (how-many (cons 100 '())) 1)
(check-expect (how-many (cons 100
                              (cons 50
                                    (cons 25
                                          (cons 12 '()))))) 4)
(define (how-many ne-l)
  (cond
    [(empty? (rest ne-l)) 1]
    [else (+ 1 (how-many (rest ne-l)))]))