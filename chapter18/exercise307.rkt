;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise307) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 307

(require 2htdp/abstraction)

; String [List-of String] -> String
; retrieves first string on the list that
; is equal to or an extension of the given string
(check-expect (find-name "kyle" (list "hello world" "kylerego"))
              "kylerego")
(define (find-name str alos)
  (for/or ([s alos]) (if
                      (string-contains? str s)
                      s
                      #false)))
  
; [List-of String] Number -> Boolean
; returns true if width of any string
; in the list is greater than n, false otherwise
(check-expect (width-checker
               '("hello" "world") 5) #false)
(check-expect (width-checker
               '("hello" "world") 4) #true)
(define (width-checker alos n)
  (for/and [(s alos)] (> (string-length s) n)))