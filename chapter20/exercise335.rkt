;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise335) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 335 + 336

(define-struct file [name size content])
; A File is a structure: 
;   (make-file String N String)

(define-struct dir [name dirs files])
; A Dir is a structure: 
;   (make-dir String Dir* File*)
 
; A Dir* is one of: 
; – '()
; – (cons Dir Dir*)
 
; A File* is one of: 
; – '()
; – (cons File File*)

(define figure123
  (make-dir "TS"
            (list
             (make-dir "Text"
                       '()
                       (list
                        (make-file "part1" 99 "")
                        (make-file "part2" 52 "")
                        (make-file "part3" 17 "")))
             (make-dir "Libs"
                       (list
                        (make-dir "Code"
                                  '()
                                  (list
                                   (make-file "hang" 8 "")
                                   (make-file "draw" 2 "")))
                        (make-dir "Docs"
                                  '()
                                  (list
                                   (make-file "read!" 19 ""))))
                       '()))
            (list
             (make-file "read!" 10 ""))))

; Dir -> Number
; counts the number of files in Dir
(check-expect (how-many figure123) 7)
(define (how-many Dir)
  (+ (how-many-dirs (dir-dirs Dir)) (length (dir-files Dir))))

(define (how-many-dirs Dirs)
  (cond
    [(empty? Dirs) 0]
    [else (+ (how-many (first Dirs)) (how-many-dirs (rest Dirs)))]))