;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise316) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 316

	
; An Atom is one of: 
; – Number
; – String
; – Symbol

; Any -> Boolean
; determines if x is an Atom
(define (atom? x)
  (or
   (number? x)
   (string? x)
   (symbol? x)))