;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname exercise258) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 258

(require 2htdp/image)

(define BACKGROUND (empty-scene 200 200))
(define TRIANGLE (list
                  (make-posn 10 10)
                  (make-posn 10 60)
                  (make-posn 100 60)))

; A Polygon is one of:
; – (list Posn Posn Posn)
; – (cons Posn Polygon)

; Image Polygon -> Image 
; adds a corner of p to img
(define (render-poly img p)
  (local (; Image NELoP -> Image
          ; connects the Posns in p in an image
          (define (connect-dots img p)
            (cond
              [(empty? (rest p)) img]
              [else (render-line (connect-dots img (rest p))
                                 (first p)
                                 (second p))]))

          ; Image Posn Posn -> Image 
          ; draws a red line from Posn p to Posn q into im
          (define (render-line im p q)
            (scene+line
             im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))

          ; Polygon -> Posn
          ; extracts the last item from p
          (define (last p)
            (cond
              [(empty? (rest (rest (rest p)))) (third p)]
              [else (last (rest p))])))
    
  (render-line (connect-dots img p) (first p) (last p))))
 
(render-poly BACKGROUND TRIANGLE)