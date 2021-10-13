;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise240) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 240

; A [Layer-of X] is one of:
; - X
; - (make-layer [Layer-of X])

; A LStr is a [Layer-of String]:
; in other words, one of:
; - String
; - (make-layer LStr)