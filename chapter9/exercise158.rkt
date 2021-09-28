;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise158) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 158
(require 2htdp/image)
(require 2htdp/universe)

(define HEIGHT 80) ; distances in terms of pixels 
(define WIDTH 100)
(define XSHOTS (/ WIDTH 2))

; graphical constants 
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 3 "solid" "red"))

; A ShotWorld is List-of-numbers. 
; interpretation each number on such a list
;   represents the y-coordinate of a shot 

; ShotWorld -> Image
; adds the image of a shot for each  y on w 
; at (MID,y) to the background image
(check-expect (to-image (cons 9 '()))
              (place-image SHOT XSHOTS 9 BACKGROUND))
(check-expect (to-image (cons 18 (cons 9 '())))
              (place-image SHOT XSHOTS 18
                           (place-image SHOT XSHOTS 9 BACKGROUND)))
(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else (place-image SHOT XSHOTS (first w) (to-image (rest w)))]))

; ShotWorld -> ShotWorld
; moves each shot on w up by one pixel
; removes a shot if its < 0
(check-expect (tock (cons 5 '())) (cons 4 '()))
(check-expect (tock (cons 3
                          (cons 5
                                (cons 7 '()))))
              (cons 2
                    (cons 4
                          (cons 6 '()))))
(check-expect (tock (cons -1 '())) '())
(define (tock w)
  (cond
    [(empty? w) '()]
    [else (tock-move w)]))

; ShotWorld -> ShotWorld
; auxiliary function for tock
; moves each shot by 1 up the canvas,
; but removes shot if it is less than 0
(define (tock-move w)
  (cond
    [(< (first w) 0) (tock (rest w))]
    [else (cons (- (first w) 1) (tock (rest w)))]))

; ShotWorld KeyEvent -> ShotWorld 
; adds a shot to the world 
; if the player presses the space bar
(check-expect (keyh (cons 7 '()) "h") (cons 7 '()))
(check-expect (keyh (cons 5 '()) " ") (cons HEIGHT
                                            (cons 5 '())))
(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w))


; ShotWorld -> ShotWorld 
(define (main w0)
  (big-bang w0
    [on-tick tock]
    [on-key keyh]
    [to-draw to-image]))

(main '())