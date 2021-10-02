;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise188) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 188

(define-struct email [from date message])
; An Email Message is a structure: 
;   (make-email String Number String)
; interpretation (make-email f d m) represents text m 
; sent by f, d seconds after the beginning of time

; A List-of-Emails is one of:
; - '()
; - (cons Email List-of-Emails)

; List-of-Emails -> List-of-Emails
; sorts the list of emails by date, in ascending order
(check-expect (sort-emails '()) '())
(check-expect (sort-emails (list (make-email "Kyle" 600 "Hello") (make-email "Ryan" 500 "World")))
              (list (make-email "Ryan" 500 "World") (make-email "Kyle" 600 "Hello")))
(check-expect (sort-emails
               (list (make-email "a" 100 "b") (make-email "c" 50 "d") (make-email "e" 25 "f")))
              (list (make-email "e" 25 "f") (make-email "c" 50 "d") (make-email "a" 100 "b")))
(define (sort-emails emails)
  (cond
    [(empty? emails) '()]
    [else (insert-email (first emails) (sort-emails (rest emails)))]))

; Email List-of-Emails -> List-of-Emails
; inserts the email into the list where it belongs
; so that the email dates are in ascending order
(check-expect (insert-email (make-email "Kyle" 100 "Hello world") '())
              (list (make-email "Kyle" 100 "Hello world")))
(define (insert-email email emails)
  (cond
    [(empty? emails) (list email)]
    [else
     (cond
       [(< (email-date email) (email-date (first emails))) (cons email emails)]
       [else (cons (first emails) (insert-email email (rest emails)))])]))