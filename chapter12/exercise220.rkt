;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise220) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 220

(require 2htdp/image)

(define WIDTH 10) ; # of blocks, horizontally
(define HEIGHT 10)
(define SIZE 10) ; blocks are squares
(define SCENE-WIDTH (* WIDTH SIZE))
(define SCENE-HEIGHT (* HEIGHT SIZE))
(define BACKGROUND (empty-scene SCENE-WIDTH SCENE-HEIGHT))
 
 
(define BLOCK ; red squares with black rims
  (overlay
    (square (- SIZE 1) "solid" "red")
    (square SIZE "outline" "black")))


(define-struct tetris [block landscape])
(define-struct block [x y])
 
; A Tetris is a structure:
;   (make-tetris Block Landscape)
; A Landscape is one of: 
; – '() 
; – (cons Block Landscape)
; A Block is a structure:
;   (make-block N N)
 
; interpretations
; (make-block x y) depicts a block whose left 
; corner is (* x SIZE) pixels from the left and
; (* y SIZE) pixels from the top;
; (make-tetris b0 (list b1 b2 ...)) means b0 is the
; dropping block, while b1, b2, and ... are resting

(define landscape0 '())
(define block-dropping (make-block 5 1))
(define tetris0 (make-tetris (make-block 5 0) landscape0))
(define tetris0-drop (make-tetris block-dropping landscape0))
(define block-top-left-corner (make-block 0 0))
(define block-landed (make-block 0 (- HEIGHT 1)))
(define block-on-block (make-block 0 (- HEIGHT 2)))
(define tetris1 (make-tetris block-dropping (list block-on-block block-landed)))

; Block Image -> Image
; renders the block onto the given image
(define (render-block blk img)
  (place-image BLOCK
               (+ (* SIZE (block-x blk)) (/ SIZE 2))
               (+ (* SIZE (block-y blk)) (/ SIZE 2))
               img))

; Tetris -> Image
; renders the tetris structure as an image
(check-expect (render-tetris tetris1)
              (render-block block-dropping
                            (render-block block-on-block
                                          (render-block block-landed BACKGROUND))))
(define (render-tetris tet)
  (cond
    [(empty? (tetris-landscape tet))
     (render-block (tetris-block tet) BACKGROUND)]
    [else (render-block
           (first (tetris-landscape tet))
           (render-tetris (make-tetris
                           (tetris-block tet)
                           (rest (tetris-landscape tet)))))]))
