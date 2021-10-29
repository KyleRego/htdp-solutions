;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise437) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 437

; [List-of Any] -> Number
(check-expect (special1 (list 1 2)) 2)
(define (special1 P)
  (cond
    [(empty? P) 0]
    [else (+
           1
           (special1 (rest P)))]))

; [List-of Number] -> [List-of Number]
(check-expect (special2 (list 1 2)) (list -1 -2))
(define (special2 P)
  {cond
    [(empty? P) '()]
    [else (cons (* -1 (first P))
                (special2 (rest P)))]})

; [List-of String] -> [List-of String]
(check-expect (special3 (list "hello" "world")) (list "Hello" "World"))
(define (special3 P)
  (cond
    [(empty? P) '()]
    [else (cons (toUpperCase (first P))
                (special3 (rest P)))]))

(check-expect (toUpperCase "hello") "Hello")
(define (toUpperCase str)
  (string-append
   (string-upcase (substring str 0 1))
   (substring str 1)))