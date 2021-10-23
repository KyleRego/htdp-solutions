;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise340) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 340

(require htdp/dir)

; A File is a structure: 
;   (make-file String N String)

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

; Dir -> String
; lists the names of all files and directories in given Dir
(define (ls dirname)
  (local ((define dirs (dir-dirs dirname))
          (define files (dir-files dirname))
          ; [List=of Dir] -> String
          (define (dirs-string dirs)
            (cond
              [(empty? dirs) ""]
              [else
               (string-append
                (dir-name (first dirs))
                " "
                (dirs-string (rest dirs)))]))
          ; [List-of File] -> String
          (define (files-string files)
            (cond
              [(empty? files) ""]
              [else
               (string-append
                (file-name (first files))
                " "
                (files-string (rest files)))])))
    (string-append
     (dirs-string dirs)
     (files-string files))))

(ls htdp-chapter1-solutions)
(ls figure123)