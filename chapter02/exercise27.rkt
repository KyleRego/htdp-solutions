;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise27) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 28

(define TICK-PRICE 5.0)
(define ATTENDANCE-AT-5-DOLLARS 120)
(define CHANGE-IN-ATTENDANCE-PER-10-CENTS 15)
(define 10-CENTS 0.1)
(define FIXED-COST-PER-SHOW 180)
(define COST-PER-ATTENDEES 0.04)

(define (attendees ticket-price)
  (- ATTENDANCE-AT-5-DOLLARS (* (- ticket-price TICK-PRICE) (/ CHANGE-IN-ATTENDANCE-PER-10-CENTS 10-CENTS))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-COST-PER-SHOW (* COST-PER-ATTENDEES (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))







   