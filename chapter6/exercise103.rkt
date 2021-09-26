;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise103) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 103

; A Spider is a structure:
;    (make-spider legs space)
; interpretation legs represents the number
; of remaining legs and space represents the
; volume necessary for transport
(define-struct spider [legs space])

; An Elephant is a structure:
;    (make-elephant space)
; interpretation space represents the
; volume needed in case of transport
(define-struct elephant [space])

; A Boa is a structure:
;    (make-boa length girth volume)
; interpretation represents a boa constrictor
; with length equal to length and girth equal to girth
; and space needed for transport equal to volume
(define-struct boa [length girth space])

; An Animal is one of:
; - Spider
; - Elephant
; - Boa

; a template for functions that consume zoo animals:
(define (f animal)
  (cond
    [(spider? animal) (... animal ...)]
    [(elephant? animal) (... animal ...)]
    [(boa? animal) (... animal ...)]))

; Animal Number -> Boolean
; Returns a bool representing if the given animal
; is able to be transported in a volume equal to vol
(check-expect (fits? (make-elephant 10) 9) #false)
(check-expect (fits? (make-boa 4 2 5) 6) #true)
(check-expect (fits? (make-spider 6 2) 2) #true)
(define (fits? animal vol)
    (cond
    [(spider? animal) (>= vol (spider-space animal))]
    [(elephant? animal) (>= vol (elephant-space animal))]
    [(boa? animal) (>= vol (boa-space animal))]))
  



  