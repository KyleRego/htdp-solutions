;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise332) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 332

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