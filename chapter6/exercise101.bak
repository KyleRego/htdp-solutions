;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise101) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH 200)
(define HEIGHT 200)
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define DISTANCE-TO-HIT 5)
(define TANK (rectangle 40 20 "solid" "blue"))
(define TANK-HEIGHT (image-height TANK))
(define MISSILE (triangle 15 "solid" "red"))
(define UFO (ellipse 20 10 "solid" "green"))
(define UFO-HEIGHT (image-height UFO))
(define UFO-DELTA-Y 0.1)
(define MISSILE-DELTA-Y -0.2)

(define-struct sigs [ufo tank missile])
; A SIGS.v2 (short for SIGS version 2) is a structure:
;   (make-sigs UFO Tank MissileOrNot)
; interpretation represents the complete state of a
; space invader game
 
; A MissileOrNot is one of: 
; – #false
; – Posn
; interpretation#false means the missile is in the tank;
; Posn says the missile is at that location


; exercise 101

; MissileOrNot Image -> Image 
; adds an image of missile m to scene s
(check-expect (missile-render.v2 #false BACKGROUND) BACKGROUND)
(check-expect (missile-render.v2
               (make-posn 32 (- HEIGHT TANK-HEIGHT 10)) BACKGROUND)
               (place-image MISSILE 32 (- HEIGHT TANK-HEIGHT 10) BACKGROUND))
(define (missile-render.v2 m s)
  (cond
    [(boolean? m) s]
    [(posn? m)
     (place-image MISSILE (posn-x m) (posn-y m) s)]))