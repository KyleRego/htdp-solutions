;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise177) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)


; Lo1s -> Lo1s 
; produces a reverse version of the given list 
(check-expect
  (rev (cons "a" (cons "b" (cons "c" '()))))
  (cons "c" (cons "b" (cons "a" '()))))
(define (rev l)
  (cond
    [(empty? l) '()]
    [else (add-to-end (first l)
           (rev (rest l)))]))

; 1String, Lo1S -> Lo1S
; adds given 1String to the end of the list)
(check-expect (add-to-end "a" (cons "a"
                                    (cons "b" '())))
              (cons "a"
                    (cons "b"
                          (cons "a" '()))))
(define (add-to-end str alos)
  (cond
    [(empty? alos) (cons str '())]
    [else (cons (first alos) (add-to-end str (rest alos)))]))

; exercise 177

; String String -> Editor
; makes an editor structure from 2 strings
(define (create-editor str1 str2)
  (make-editor (explode str1) (explode str2)))

