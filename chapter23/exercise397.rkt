;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise397) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 397

(require 2htdp/abstraction)

(define-struct timecard [id hours])
; a TimeCard is a structure:
;     (make-timecard Number Number)
; interpretation: id is employee number
; and hours is number hours worked per week

(define-struct record [name id prate])
; a Record is a structure:
;     (make-record String Number Number)
; interpretation: name is the employee name,
; id is employee number, and prate is hourly pay

(define-struct wagerecord [name wage])
; a WageRecord is a structure:
;    (make-wagerecord String Number)
; interpretation: name is the employee name,
; wage is their weekly pay

(define timecard1 (make-timecard 1 10))
(define record1 (make-record "Kyle" 1 15))
(define wagerecord1 (make-wagerecord "Kyle" 150))

(define timecard2 (make-timecard 2 20))
(define record2 (make-record "Dan" 2 15))
(define wagerecord2 (make-wagerecord "Dan" 300))


; [List-of Record] [List-of TimeCard] -> [List-of WageRecord]
; assumes an equal number of records and timecards
(check-expect (wages (list record1) (list timecard1)) (list wagerecord1))
(check-expect (wages (list record1 record2) (list timecard1 timecard2))
              (list wagerecord1 wagerecord2))
(check-expect (wages (list record2 record1) (list timecard1 timecard2))
              (list wagerecord2 wagerecord1))
(define (wages alor alotc)
  (remove-empty-lists
  (for*/list ((record_ alor) (timecard_ alotc))
    (if (equal? (timecard-id timecard_) (record-id record_))
        (make-wagerecord (record-name record_)
                         (* (record-prate record_)
                            (timecard-hours timecard_)))
        '()))))

; List -> List
; removes all '() from the list
(define (remove-empty-lists list)
  (cond
    [(empty? list) '()]
    [(equal? (first list) '()) (remove-empty-lists (rest list))]
    [else (cons (first list) (remove-empty-lists (rest list)))]))
       