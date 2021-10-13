;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise130) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 130

; A List-of-names is one of: 
; – '()
; – (cons String List-of-names)
; interpretation a list of invitees, by last name

;e.g. a List-of-names with 5 Strings

(cons "Kyle"
      (cons "Ryan"
            (cons "Abigail"
                  (cons "Nate"
                        (cons "Erin" '())))))

(cons 2 '())
; not a List-of-names because 2 is not a String