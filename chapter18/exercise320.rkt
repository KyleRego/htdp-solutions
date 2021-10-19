;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise320) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 320

; An S-expr is one of:
; - Number
; - String
; - Symbol
; - [List-of S-expr]

; S-expr Symbol -> N
; counts all occurrences of sy in sexp
(check-expect (count 'world 'hello) 0)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(((world) hello) hello) 'hello) 2)

(define (count sexp sy)
  (local (; [List-of S-expr] Symbol -> Number
          ; counts all occurrences of sy in sexp
          (define (count-sl sexp sy)
            (cond
              [(empty? sexp) 0]
              [else
                (+ (count (first sexp) sy)
                   (count-sl (rest sexp) sy))])))
  (cond
    [(number? sexp) 0 ]
    [(string? sexp) 0 ]
    [(symbol? sexp) (if (equal? sexp sy) 1 0) ]
    [else (count-sl sexp sy) ])))