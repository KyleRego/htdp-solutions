;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise83) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 83

(require 2htdp/image)


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



