;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise179) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define HEIGHT 20) ; the height of the editor 
(define WIDTH 200) ; its width 
(define FONT-SIZE 16) ; the font size 
(define FONT-COLOR "black") ; the font color 
 
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))


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



; Editor -> Image
; renders an editor as an image of the two texts 
; separated by the cursor 
; Editor -> Image
(define (editor-render e)
  (place-image/align
    (beside (editor-text (reverse (editor-pre e)))
            CURSOR
            (editor-text (editor-post e)))
    1 1
    "left" "top"
    MT))

(check-expect
  (editor-text
   (cons "p" (cons "o" (cons "s" (cons "t" '())))))
  (text "post" FONT-SIZE FONT-COLOR))
(define (editor-text s)
  (text (implode s) FONT-SIZE FONT-COLOR))


 
; Editor KeyEvent -> Editor
; deals with a key event, given some editor
(check-expect (editor-kh (create-editor "" "") "e")
              (create-editor "e" ""))
(check-expect
  (editor-kh (create-editor "cd" "fgh") "e")
  (create-editor "ecd" "fgh"))
(check-expect
 (editor-kh (create-editor "ab" "cd") "\b")
 (create-editor "b" "cd"))
(check-expect
 (editor-kh (create-editor "" "ab") "\b")
 (create-editor "" "ab"))
(check-expect
 (editor-kh (create-editor "ab" "cd") "left")
 (create-editor "b" "acd"))
(check-expect
 (editor-kh (create-editor "ab" "cd") "right")
 (create-editor "cab" "d"))
(check-expect
 (editor-kh (create-editor "ab" "") "right")
 (create-editor "ab" ""))
(check-expect
 (editor-kh (create-editor "" "ab") "left")
 (create-editor "" "ab"))
(define (editor-kh ed k)
  (cond
    [(key=? k "left") (editor-lft ed)]
    [(key=? k "right") (editor-rgt ed)]
    [(key=? k "\b") (editor-del ed)]
    [(key=? k "\t") ed]
    [(key=? k "\r") ed]
    [(= (string-length k) 1) (editor-ins ed k)]
    [else ed]))

; exercise 179

; Editor -> Editor
; moves the cursor position one 1String left, 
; if possible
(define (editor-lft ed)
  (cond
    [(empty? (editor-pre ed)) ed]
    [else (create-editor
           (implode (rest (editor-pre ed)))
           (implode (cons (first (editor-pre ed)) (editor-post ed))))]))
           

; Editor -> Editor
; moves the cursor position one 1String right, 
; if possible 
(define (editor-rgt ed)
  (cond
    [(empty? (editor-post ed)) ed]
    [else (create-editor
           (implode (cons (first (editor-post ed)) (editor-pre ed)))
           (implode (rest (editor-post ed))))]))
 
; Editor -> Editor
; deletes a 1String to the left of the cursor,
; if possible 
(define (editor-del ed)
  (cond
    [(empty? (editor-pre ed)) ed]
    [else (create-editor
           (implode (rest (editor-pre ed)))
           (implode (editor-post ed)))]))

; insert the 1String k between pre and post
(define (editor-ins ed k)
  (make-editor (cons k (editor-pre ed))
               (editor-post ed)))

; main : String -> Editor
; launches the editor given some initial string 
(define (main s)
   (big-bang (create-editor s "")
     [on-key editor-kh]
     [to-draw editor-render]))

(main "")