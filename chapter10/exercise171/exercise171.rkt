;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise171) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 171

(require 2htdp/batch-io)

; a List-of-strings is one of:
; - '()
; - (cons String List-of-strings)

; a List-of-list-of-strings is one of:
; - '()
; - (cons List-of-strings List-of-list-of-strings)

(read-words/line "TTT.txt")