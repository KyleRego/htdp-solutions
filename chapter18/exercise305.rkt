;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise305) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 305

(require 2htdp/abstraction)

(check-expect (convert-euro '(1.06 1.06 1.06)) '(1 1 1))
(define (convert-euro alod)
  (for/list ([dollar alod]) (/ dollar 1.06)))
  