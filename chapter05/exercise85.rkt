;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise85) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 84

(require 2htdp/image)
(require 2htdp/universe)


(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t


; Editor -> Image
; renders the editor E into an image
(check-expect (render (make-editor "hello" "world")) (overlay/align "left" "center"
               (beside (text "hello" 11 "black") (rectangle 1 20 "solid" "red") (text "world" 11 "black")) 
               (empty-scene 200 20)))
(define (render E)
  (overlay/align "left" "center"
                 (beside
                  (text (editor-pre E) 11 "black")
                  (rectangle 1 20 "solid" "red")
                  (text (editor-post E) 11 "black"))
                 (empty-scene 200 20)))

; Editor, KeyEvent -> Editor
; produces a new Editor with a new character
; appended to the end of pre field of ed
(check-expect (edit (make-editor "hello" "world") "_") (make-editor "hello_" "world"))
(check-expect (edit (make-editor "hello" "world") "\b") (make-editor "hell" "world"))
(check-expect (edit (make-editor "hello" "world") "\t") (make-editor "hello" "world"))
(define (edit ed ke)
  (cond
    [(key=? ke "\b") (make-editor (delete-last (editor-pre ed)) (editor-post ed))]
    [(key=? ke "\t") ed]
    [(key=? ke "\r") ed]
    [(= (string-length ke) 1) (make-editor (string-append (editor-pre ed) ke) (editor-post ed))]))

; String -> String
; removes the last character of the string
(check-expect (delete-last "hello") "hell")
(define (delete-last str)
  (substring str 0 (- (string-length str) 1)))

; launches the world program for an editor
(define (run pre)
  (big-bang (make-editor pre "")
    (to-draw render)
    (on-key edit)))

(run "hello")
  
                               


