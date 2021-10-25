;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise389) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 389

(require 2htdp/abstraction)

(define-struct phone-record [name number])
; A PhoneRecord is a structure:
;   (make-phone-record String String)

; [List-of String] [List-of String] ->
; [List-of PhoneRecord]
; combines a list of names and a list
; of phone numbers into a list of PhoneRecords
(check-expect (zip (list "Kyle" "Ryan") (list 100 200))
              (list (make-phone-record "Kyle" 100)
                    (make-phone-record "Ryan" 200)))
(define (zip alos-names alos-phones)
  (for/list ((name alos-names) (phone alos-phones))
    (make-phone-record name phone)))