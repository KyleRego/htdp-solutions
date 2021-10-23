;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise341) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 341

(require htdp/dir)
(require 2htdp/abstraction)

; (define-struct file [name size content])
; A File is a structure: 
;   (make-file String N String)

; (define-struct dir [name dirs files])
; A Dir is a structure: 
;   (make-dir String Dir* File*)
 
; A Dir* is a [List-of Dir]
; A File* is a [List-of File]

(define htdp-chapter1-solutions
  (create-dir "C:\\Users\\regok\\OneDrive\\Desktop\\htdp\\chapter01"))

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
; computes total size of all files in the directory tree
; assuming that a directory itself is 1 file storage unit
(check-expect (du figure123) 212)
(define (du d)
  (local ((define d-dirs (dir-dirs d))
          (define d-files (dir-files d)))
    (+
     1
     (for/sum [(d-dir d-dirs)] (du d-dir))
     (for/sum [(d-file d-files)] (file-size d-file)))))
  