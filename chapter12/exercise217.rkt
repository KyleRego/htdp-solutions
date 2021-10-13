;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise217) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 217

(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH 100)
(define HEIGHT 100)
(define WORM-SEGMENT-RADIUS 4)

(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define worm-segment
  (circle WORM-SEGMENT-RADIUS "solid" "red"))

; A Worm is a List-of-WSs or one of:
; - '()
; - (cons WS Worm)

(define-struct ws [pos dir])
; A WS (worm segment) is a structure
;     (make-ws Posn Direction)
; represents a worm-segment at the position
; moving in the given direction

; A Direction is one of:
; "pos-x"
; "neg-x"
; "pos-y"
; "neg-y"

(define example-worm
  (list
   (make-ws (make-posn 25 25) "pos-x")
   (make-ws (make-posn (- 25 WORM-SEGMENT-RADIUS) 25) "pos-x")
   (make-ws (make-posn (- 25 (* 2 WORM-SEGMENT-RADIUS)) 25) "pos-x")))

(define example-worm2
  (list
   (make-ws (make-posn (- 25 WORM-SEGMENT-RADIUS) 25) "pos-x")
   (make-ws (make-posn (- 25 (* 2 WORM-SEGMENT-RADIUS)) 25) "pos-x")
   (make-ws (make-posn (- 25 (* 3 WORM-SEGMENT-RADIUS)) 25) "pos-x")))

(define example-worm3
  (list
   (make-ws (make-posn (- 25 WORM-SEGMENT-RADIUS) 25) "pos-x")
   (make-ws (make-posn (- 25 (* 2 WORM-SEGMENT-RADIUS)) 25) "pos-x")))

(define example-worm4
  (list
   (make-ws (make-posn (- 25 WORM-SEGMENT-RADIUS) 25) "neg-x")
   (make-ws (make-posn (- 25 (* 2 WORM-SEGMENT-RADIUS)) 25) "pos-x")))
  
   

; Worm -> Image
; renders the image of the entire worm
(check-expect (render-worm '()) BACKGROUND)
(define (render-worm worm)
  (cond
    [(empty? worm) BACKGROUND]
    [else (render-ws (first worm) (render-worm (rest worm)))]))
  

; WS -> Image
; renders the image of the worm-segment
(check-expect (render-ws (make-ws (make-posn 50 50) "pos-x") BACKGROUND)
              (place-image worm-segment 50 50 BACKGROUND))
              
(define (render-ws ws img)
  (place-image worm-segment
               (posn-x (ws-pos ws))
               (posn-y (ws-pos ws))
               img))

; Worm -> Worm
; removes the last worm-segment and adds a new worm segment
; according to the direction the first worm-segment is moving
(check-expect (move-worm '()) '())
(check-expect (move-worm example-worm2) example-worm)
(define (move-worm worm)
  (cond
    [(empty? worm) '()]
    [else (remove-last (append
                        (list (move (first worm)) (first worm))
                        (rest worm)))]))

; Worm -> Worm
; returns the worm without the last segment
(check-expect (remove-last example-worm2) example-worm3)
(define (remove-last worm)
  (cond
    [(empty? worm) '()]
    [(empty? (rest worm)) '()]
    [else (cons (first worm) (remove-last (rest worm)))]))

; WS -> WS
; moves the worm-segment a distance one diameter
; in its direction
(check-expect (move (make-ws (make-posn 50 50) "neg-y"))
              (make-ws (make-posn 50 (- 50 WORM-SEGMENT-RADIUS)) "neg-y"))
(check-expect (move (make-ws (make-posn 50 50) "pos-y"))
              (make-ws (make-posn 50 (+ 50 WORM-SEGMENT-RADIUS)) "pos-y"))
(check-expect (move (make-ws (make-posn 50 50) "pos-x"))
              (make-ws (make-posn (+ 50 WORM-SEGMENT-RADIUS) 50) "pos-x"))
(check-expect (move (make-ws (make-posn 50 50) "neg-x"))
              (make-ws (make-posn (- 50 WORM-SEGMENT-RADIUS) 50) "neg-x"))
(define (move ws)
  (cond
    [(string=? (ws-dir ws) "pos-x")
     (make-ws (make-posn
               (+ WORM-SEGMENT-RADIUS (posn-x (ws-pos ws)))
               (posn-y (ws-pos ws)))
              "pos-x")]
    [(string=? (ws-dir ws) "neg-x")
     (make-ws (make-posn
               (- (posn-x (ws-pos ws)) WORM-SEGMENT-RADIUS)
               (posn-y (ws-pos ws)))
              "neg-x")]
    [(string=? (ws-dir ws) "pos-y")
     (make-ws (make-posn
               (posn-x (ws-pos ws))
               (+ WORM-SEGMENT-RADIUS (posn-y (ws-pos ws))))
              "pos-y")]
    [(string=? (ws-dir ws) "neg-y")
     (make-ws (make-posn
               (posn-x (ws-pos ws))
               (- (posn-y (ws-pos ws)) WORM-SEGMENT-RADIUS))
              "neg-y")]))

; Worm KeyEvent -> Worm
; changes the direction of the Worm according
; to the left, right, up, and down keys
(define (key-handler worm key)
  (cond
    [(string=? key "up") (redirect-worm worm "neg-y")]
    [(string=? key "down") (redirect-worm worm "pos-y")]
    [(string=? key "left") (redirect-worm worm "neg-x")]
    [(string=? key "right") (redirect-worm worm "pos-x")]
    [else worm]))

; Worm Direction -> Worm
; makes a new worm where the first worm-segment
; is moving in the given Direction
(check-expect (redirect-worm example-worm3 "neg-x") example-worm4)
(define (redirect-worm worm direction)
  (append
   (list (make-ws (ws-pos (first worm)) direction))
   (rest worm)))

(define (main worm)
  (big-bang worm
    (to-draw render-worm)
    (on-tick move-worm 0.25)
    (on-key key-handler)))
(main example-worm)