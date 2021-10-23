;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise333) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 333

(define-struct dir [name content])
; A Dir is a structure: 
;   (make-dir String LOFD)
 
; An LOFD (short for list of files and directories) is one of:
; – '()
; – (cons File LOFD)
; – (cons Dir LOFD)
 
; A File is a String.

(define figure123
  (make-dir "TS"
            (list
             (make-dir "Text"
                       (list
                        "part1"
                        "part2"
                        "part3"))
             "read!"
             (make-dir "Libs"
                       (list
                        (make-dir "Code"
                                  (list
                                   "hang"
                                   "draw"))
                        (make-dir "Docs"
                                  (list
                                   "read!")))))))
; Dir -> Number
; determines how many files dir has
(check-expect (how-many figure123) 7)
(define (how-many Dir)
  (local ((define cont (dir-content Dir)))
    (cond
      [(empty? cont) 0]
      [(string? (first cont)) (+ 1 (how-many-lofd (rest cont)))]
      [else (+ (how-many (first cont)) (how-many-lofd (rest cont)))])))

; LOFD -> Number
; determines how many files are in a list of files and dirs
(define (how-many-lofd lofd)
  (cond
    [(empty? lofd) 0]
    [(string? (first lofd)) (+ 1 (how-many-lofd (rest lofd)))]
    [else (+ (how-many (first lofd)) (how-many-lofd (rest lofd)))]))