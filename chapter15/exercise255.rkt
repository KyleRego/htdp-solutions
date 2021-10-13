;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise255) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 255

; [List-of Number] [Number -> Number] -> [List-of Number]
(define (map-n alon func) alon)

; [List-of String] [String -> String] -> [List-of String]
(define (map-s alos func) alos)

; [X] [List-of X] [X -> X] -> [List-of X]