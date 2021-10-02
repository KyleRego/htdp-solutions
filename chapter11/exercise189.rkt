;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise189) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 189

; Number List-of-numbers -> Boolean
; returns #true if the number is in the
; list of numbers, and assumes that the
; list is sorted in descending order
(check-expect (search-sorted 5 '()) #false)
(check-expect (search-sorted 5 (list 4 3 2)) #false)
(check-expect (search-sorted 5 (list 9 7 5 3)) #true)
(define (search-sorted n alon)
  (cond
    [(empty? alon) #false]
    [(< (first alon) n) #false]
    [else (or (= (first alon) n)
              (search-sorted n (rest alon)))]))