;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise59) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 59

(require 2htdp/image)
(require 2htdp/universe)

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume

; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))

; TrafficLight -> TrafficLight
; yields the next state, given current state cs
(check-expect (tl-next "red") "green")
(check-expect (tl-next "green") "yellow")
(check-expect (tl-next "yellow") "red")
(define (tl-next cs)
  (cond
    [(string=? cs "red") "green"]
    [(string=? cs "green") "yellow"]
    [(string=? cs "yellow") "red"]))
 
; TrafficLight -> Image
; renders the current state cs as an image
(define (tl-render current-state)
  (cond
    [(string=? current-state "red") (place-image (circle 12 "solid" "red") 15 15 (empty-scene 90 30))]
    [(string=? current-state "yellow") (place-image (circle 12 "solid" "yellow") 45 15 (empty-scene 90 30))]
    [(string=? current-state "green") (place-image (circle 12 "solid" "green") 75 15 (empty-scene 90 30))]))

(traffic-light-simulation "red")