;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise319) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 319

; An Atom is one of: 
; – Number
; – String
; – Symbol

; An S-expr is one of: 
; – Atom
; – SL
 
; An SL is one of: 
; – '()
; – (cons S-expr SL)

; Any -> Boolean
; determines if x is an Atom
(define (atom? x)
  (or
   (number? x)
   (string? x)
   (symbol? x)))

; Symbol Symbol S-expr -> S-expr
; replaces all instances of old with new
(check-expect (substitute 'hello 'world 'hello) 'world)
(check-expect (substitute 'hello 'world (list (list (list 'hello))))
              (list (list (list 'world))))
(define (substitute old new sexp)
  (cond
    [(atom? sexp) (replace-atom old new sexp)]
    [else (replace-sl old new sexp)]))

; Symbol Symbol Atom -> Atom
(define (replace-atom old new atom)
  (cond
    [(number? atom) atom]
    [(string? atom) atom]
    [(symbol? atom)
     (if (equal? atom old) new old)]))

; Symbol Symbol SL -> SL
;(check-expect (replace-sl 'hello 'world (list 'hello)) (list 'world))
(check-expect (replace-sl 'hello 'world
                          (list (list 'hello)))
              (list (list 'world)))
(define (replace-sl old new sl)
  (cond
    [(empty? sl) sl]
    [else
     (cons
      (substitute old new (first sl))
      (replace-sl old new (rest sl)))]))