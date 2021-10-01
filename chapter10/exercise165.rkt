;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise165) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 165

; a List-of-strings is one of:
; - '()
; - (cons String List-of-strings)

; List-of-strings -> List-of-strings
; replaces all occurrences of "robot" with "r2d2"
; in the list of strings provided
(check-expect (subst-robot '()) '())
(check-expect (subst-robot (cons "robot" '())) (cons "r2d2" '()))
(check-expect (subst-robot (cons "hello" (cons "world" '())))
              (cons "hello" (cons "world" '())))
(check-expect (subst-robot (cons "hello" (cons "world" (cons "robot" '()))))
              (cons "hello" (cons "world" (cons "r2d2" '()))))
(define (subst-robot alos)
  (cond
    [(empty? alos) '()]
    [else (cons (if (string=? (first alos) "robot")
                    "r2d2"
                    (first alos))
                (subst-robot (rest alos)))]))

; String String List-of-strings -> List-of-strings
; replaces all occurrences of old with new in the provided list
(check-expect (substitute "hello" "world" '()) '())
(check-expect (substitute "hello" "world" (cons "world" '())) (cons "hello" '()))
(check-expect (substitute "angry" "happy" (cons "hello"
                                                (cons "world"
                                                      (cons "happy"
                                                            (cons "angry" '())))))
              (cons "hello" (cons "world" (cons "angry" (cons "angry" '())))))
(define (substitute new old alos)
    (cond
    [(empty? alos) '()]
    [else (cons (if (string=? (first alos) old)
                    new
                    (first alos))
                (substitute new old (rest alos)))]))