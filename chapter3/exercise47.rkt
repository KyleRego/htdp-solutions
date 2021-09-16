;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise47) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 47

(require 2htdp/image)
(require 2htdp/universe)

; A WorldState (ws) represents a Number between 0 and 100
; which represents a happiness gauge

(define (main ws)
  (big-bang ws
    (on-tick subtract-happiness)
    (on-key key-handler)
    (to-draw render)))

; WorldState -> Image
; draws the happiness gauge for given WorldState
(define (render ws)
  (rectangle ws 10 "solid" "green"))

; WorldState -> WorldState
; subtracts 0.1 from the WorldState
(check-expect (subtract-happiness 50) 49.9)
(check-expect (subtract-happiness 36.5) 36.4)
(define (subtract-happiness ws)
  (- ws 0.1))

; WorldState, KeyEvent -> WorldState
; decreases WorldState by 1/5 for a down arrow
; increases WorldState by 1/3 for an up arrow
(check-expect (key-handler 1 "down") 4/5)
(check-expect (key-handler 10 "up") 40/3)
(check-expect (key-handler 50 "left") 50)
(define (key-handler ws key)
  (cond
    [(key=? key "down") (- ws (* 1/5 ws))]
    [(key=? key "up") (+ ws (* 1/3 ws))]
    [else ws]))

(main 100)


