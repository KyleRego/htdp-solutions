;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise388) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 388

(require 2htdp/abstraction)

(define-struct employee [name ssn pay])
; An Employee is a structure:
; (make-employee String String Number)
; represents an employee with a name,
; social security number, and pay equal
; to their hourly pay rate

(define-struct work-record [name hours])
; A WorkRecord is a structure:
; (make-word-record String Number)
; represents a weekly work record of employee
; name, and hours is the number of hours worked

(define e1 (make-employee "Kyle" 0 15))
(define wr1 (make-work-record "Kyle" 20))

; [List-of Employee] [List-of WorkRecord] ->
; [List-of (cons Number (cons String '()))]
; produces a list of associations of employee names
; with their weekly wages
(check-expect (wages (list e1) (list wr1))
              (list (cons 300 (cons "Kyle" '()))))
(define (wages aloe alowr)
  (for/list ((e aloe) (wr alowr))
    (list
     (*
     (employee-pay e)
     (work-record-hours wr))
     (employee-name e))))