;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise38) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; exercise 38

; String -> String
; takes a string and returns a new string
; like the given one with the last character removed
; given: "hello world", expect: "hello worl"
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))




