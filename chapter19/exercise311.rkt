;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise311) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 311

(define-struct no-parent [])
(define-struct child [father mother name date eyes])
; An FT (short for family tree) is one of: 
; – (make-no-parent)
; – (make-child FT FT String N String)

(define NP (make-no-parent))
; An FT is one of: 
; – NP
; – (make-child FT FT String N String)

; Oldest Generation:
(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))
 
; Middle Generation:
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))
 
; Youngest Generation: 
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

(define YEAR 2021)

; FT -> [Maybe Number]
; calculates the average age of all childs in the family tree
; assuming the age is current year (2021) minus year born
; returns false if the FT is empty
(check-expect (average-age NP) #false)
(check-expect (average-age Carl) (- YEAR 1926))
(check-expect (average-age Adam) (/ (+ (- YEAR 1926)
                                       (- YEAR 1926)
                                       (- YEAR 1950)) 3))
(define (average-age an-ftree)
  (local (; FT -> Number
          ; sums all the ages of the an-ftree
          (define (count-ages an-ftree)
            (cond
              [(no-parent? an-ftree) 0]
              [else (+ (- YEAR (child-date an-ftree))
                       (count-ages (child-father an-ftree))
                       (count-ages (child-mother an-ftree)))])))
          (cond
            [(no-parent? an-ftree) #false]
            [else
             (/ (count-ages an-ftree)
                (count-persons an-ftree))])))




; FT -> Number
; counts the number of childs in the an-ftree
(check-expect (count-persons Carl) 1)
(check-expect (count-persons Adam) 3)
(check-expect (count-persons Gustav) 5)
(define (count-persons an-ftree)
  (cond
    [(no-parent? an-ftree) 0]
    [else (+ 1
             (count-persons (child-father an-ftree))
             (count-persons (child-mother an-ftree)))]))