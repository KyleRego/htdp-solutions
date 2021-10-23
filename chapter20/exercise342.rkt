;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise342) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 342

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

; A Path is [List-of String].
; interpretation directions into a directory tree


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

; Dir String -> Boolean
; consumes a Dir and filename and determines whether that file
; exists in the Dir
(check-expect (find? figure123 "part3") #true)
(check-expect (find? figure123 "part4") #false)
(define (find? dirname filename)
  (local ((define dir* (dir-dirs dirname))
          (define file* (dir-files dirname))
          ; Dir -> Boolean
          (define (find?_ dirname_) (find? dirname_ filename)))
    (or
     (ormap find?_ dir*)
     (has-file? file* filename))))

; File* String -> Boolean
; determines if one of the files has name equal to filename
(define (has-file? files filename)
  (cond
    [(empty? files) #false]
    [else
     (or
      (equal? (file-name (first files)) filename)
      (has-file? (rest files) filename))]))

; Dir String -> [Maybe Path]
; if a file with name equal to f is in d,
; then returns the path to that file
(check-expect (find figure123 "part4") #false)
(check-expect (find figure123 "draw")
              (list "TS" "Libs" "Code" "draw"))
(define (find d f)
  (if
   (find? d f)
   (path-to-f d f)
   #false))

; Dir String -> Path
; returns the path to the given f in d
(check-expect (path-to-f figure123 "part1") (list "TS" "Text" "part1"))
(check-expect (path-to-f figure123 "draw") (list "TS" "Libs" "Code" "draw"))
(define (path-to-f d f)
  (if
   (has-file? (dir-files d) f)
   (list (dir-name d) f)
   (for/or ([d_ (dir-dirs d)])
     (if
      (find? d_ f)
      (append (list (dir-name d))
              (path-to-f d_ f))
      #false))))