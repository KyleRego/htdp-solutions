;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise41) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 41

(require 2htdp/image)
(require 2htdp/universe)

(define WHEEL-RADIUS 10)
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define CAR-BODY (rectangle (* 4 WHEEL-RADIUS) (* 2 WHEEL-RADIUS) "solid" "red"))
(define HALF-CAR (underlay/offset CAR-BODY (* 2 WHEEL-RADIUS) (* 1 WHEEL-RADIUS) WHEEL))
(define CAR (underlay/offset HALF-CAR (* -2.4 WHEEL-RADIUS) (* 0.6 WHEEL-RADIUS) WHEEL))

(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define BACKGROUND (underlay/xy (empty-scene 250 50) 50 25 tree))
(define Y-CAR 25)




; WorldState -> WorldState
; launches the program from some initial state 
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [to-draw render]
     [stop-when end?]))

; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
; examples: 
;   given: 20, expect 23
;   given: 78, expect 81
(define (tock cw)
  (+ cw 3))

; WorldState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state 
 (define (render cw)
   (place-image CAR cw Y-CAR BACKGROUND))

; WorldState -> Boolean
; after each event, big-bang evaluates (end? cw) 
(define (end? cw)
  (>= (- cw (/ (image-width CAR) 2)) (image-width BACKGROUND)))

(main 0)




