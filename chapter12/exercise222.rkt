;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise222) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 220 + 221 + 222

(require 2htdp/image)
(require 2htdp/universe)

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
(define block-dropping2 (make-block 5 2))
(define tetris0 (make-tetris (make-block 5 0) landscape0))
(define tetris0-drop (make-tetris block-dropping landscape0))
(define block-top-left-corner (make-block 0 0))
(define block-landed (make-block 0 (- HEIGHT 1)))
(define block-on-block (make-block 0 (- HEIGHT 2)))
(define block-falling-on-block (make-block 0 (- HEIGHT 3)))
(define tetris1 (make-tetris block-dropping (list block-on-block block-landed)))
(define tetris2 (make-tetris block-dropping2 (list block-on-block block-landed)))
(define tetris3 (make-tetris block-falling-on-block (list block-on-block block-landed)))
(define tetris4 (make-tetris (make-block 1 0) (list block-falling-on-block block-on-block block-landed)))

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
; exercise 221

; Tetris -> Tetris
; moves the falling block down by 1
; if it overlaps with a block, stops it from moving
; and generates a new block at the top, 1 to the right, instead
(check-expect (move tetris1) tetris2)
(check-expect (move tetris3) tetris4)
(define (move tet)
  (cond
    [(no-overlap (move-block (tetris-block tet)) tet)
     (make-tetris (move-block (tetris-block tet))
                  (tetris-landscape tet))]
    [else (make-tetris (make-block-right (tetris-block tet))
                       (cons (tetris-block tet) (tetris-landscape tet)))]))

; Block -> Block
; moves the block down 1 unit
(check-expect (move-block block-on-block) block-landed)
(define (move-block blk)
  (make-block (block-x blk) (+ 1 (block-y blk))))

; Block Tetris -> Boolean
; determines if the block does not overlap with the
; tetris's landscape, return true if no overlap
; also returns false if block is at y = HEIGHT
(check-expect (no-overlap block-top-left-corner
                          tetris1)
              #true)
(check-expect (no-overlap (make-block 0 8)
                          tetris1)
              #false)
(define (no-overlap blk tet)
  (cond
    [(empty? (tetris-landscape tet))
     (if (= (block-y blk) HEIGHT)
         #false
         #true)]
    [else (and
           (no-overlap-block
            blk
            (first (tetris-landscape tet)))
           (no-overlap blk (make-tetris
                            blk
                            (rest (tetris-landscape tet)))))]))

; Block Block -> Boolean
; determines if the two blocks do not overlap
; returns true if no overlap
(check-expect (no-overlap-block block-landed block-on-block) #true)
(check-expect (no-overlap-block block-landed block-landed) #false)
(define (no-overlap-block blk1 blk2)
  (not (and
   (= (block-x blk1) (block-x blk2))
   (= (block-y blk1) (block-y blk2)))))

; Block -> Block
; makes a new block at the top and one
; unit to the right of the old block
; if old block is on rightmost column,
; makes a new block on the leftmost column
(check-expect (make-block-right (make-block 6 6)) (make-block 7 0))
(check-expect (make-block-right (make-block 9 8)) (make-block 0 0))
(define (make-block-right blk)
  (if (= (block-x blk) (- WIDTH 1))
      (make-block 0 0)
      (make-block (+ 1 (block-x blk)) 0)))

; Tetris KeyEvent -> Tetris

(define (key-handler tet key)
  (cond
    [(and
      (key=? key "left")
      (no-overlap (move-block-left (tetris-block tet)) tet))
     (make-tetris
      (move-block-left (tetris-block tet))
      (tetris-landscape tet))]
    [(and
      (key=? key "right")
      (no-overlap (move-block-right (tetris-block tet)) tet))
     (make-tetris
      (move-block-right (tetris-block tet))
      (tetris-landscape tet))]
    [else tet]))

; Block -> Block
; moves the block one to the left
; moving past the left side makes the blocl
; appear on the right side
(define (move-block-left blk)
  (if (= (block-x blk) 0)
      (make-block (- WIDTH 1) (block-y blk))
      (make-block (- (block-x blk) 1) (block-y blk))))

; Block -> Block
; moves the block one to the right
; moving past the right side makes the block
; appear on the left side
(define (move-block-right blk)
  (if (= (block-x blk) (- WIDTH 1))
      (make-block 0 (block-y blk))
      (make-block (+ (block-x blk) 1) (block-y blk))))


(define (tetris-main tet ticks)
  (big-bang tet
    (on-key key-handler)
    (to-draw render-tetris)
    (on-tick move ticks)))

(tetris-main tetris0 0.5)
