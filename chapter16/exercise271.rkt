;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise271) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 271

; String [List-of String] -> Boolean
; determines whether any of the strings
; in the list are equal to or an extension
; of the given string
(check-expect (find-name "kyle" (list "ryan")) #false)
(check-expect (find-name "kyle" (list "kylerego")) #true)
(define (find-name str alos)
  (local ( ; String String -> Boolean
          (define (helper str_)
            (string-contains-ci? str str_)))

  (ormap helper alos)))

; use andmap to ensure no name on some list exceeds a given width