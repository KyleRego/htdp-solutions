;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise215) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 215

(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH 100)
(define HEIGHT 100)
(define WORM-SEGMENT-RADIUS 4)

(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define worm-segment
  (circle WORM-SEGMENT-RADIUS "solid" "red"))

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


; WS -> Image
; renders the image of the worm-segment
(check-expect (render-ws (make-ws (make-posn 50 50) "pos-x"))
              (place-image worm-segment 50 50 BACKGROUND))
              
(define (render-ws ws)
  (place-image worm-segment
               (posn-x (ws-pos ws))
               (posn-y (ws-pos ws))
               BACKGROUND))

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

; WS KeyEvent -> WS
; changes the direction of the WS according
; to the left, right, up, and down keys
(define (key-handler ws key)
  (cond
    [(string=? key "up") (make-ws (ws-pos ws) "neg-y")]
    [(string=? key "down") (make-ws (ws-pos ws) "pos-y")]
    [(string=? key "left") (make-ws (ws-pos ws) "neg-x")]
    [(string=? key "right") (make-ws (ws-pos ws) "pos-x")]
    [else ws]))

(define (main ws)
  (big-bang ws
    (to-draw render-ws)
    (on-tick move 0.25)
    (on-key key-handler)))

(main (make-ws (make-posn 50 50) "pos-x"))
