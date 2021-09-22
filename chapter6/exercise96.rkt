;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise96) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define WIDTH 200)
(define HEIGHT 200)
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define TANK (rectangle 40 20 "solid" "blue"))
(define TANK-HEIGHT (image-height TANK))
(define MISSILE (triangle 15 "solid" "red"))
(define UFO (ellipse 20 10 "solid" "green"))

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)

(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game



; Tank Image -> Image
; places the tank on the image
; at the tank's x coordinate and on the bottom
(check-expect (place-tank (make-tank 28 -3) BACKGROUND) (place-image TANK 28 (- HEIGHT (/ (image-height TANK) 2)) BACKGROUND))
(define (place-tank tnk image)
  (place-image TANK (tank-loc tnk) (- HEIGHT (/ (image-height TANK) 2)) image))

; UFO Image -> Image
; places the UFO on the image
; at the UFO's x and y coordinates
(check-expect (place-UFO (make-posn 20 10) BACKGROUND) (place-image UFO 20 10 BACKGROUND))
(define (place-UFO ufo image)
  (place-image UFO (posn-x ufo) (posn-y ufo) image))

; Missile Image -> Image
; places the missile on the image
; at the missile's x and y coordinates
(check-expect (place-missile (make-posn 22 103) BACKGROUND) (place-image MISSILE 22 103 BACKGROUND))
(define (place-missile mis image)
  (place-image MISSILE (posn-x mis) (posn-y mis) image))


; exercise 96

; mockups
; (make-aim (make-posn 20 10) (make-tank 28 -3))
(place-UFO (make-posn 20 10) (place-tank (make-tank 28 -3) BACKGROUND))

; (make-fired (make-posn 20 10) (make-tank 28 -3) (make-posn 28 (- HEIGHT TANK-HEIGHT)))
(place-missile (make-posn 28 (- HEIGHT TANK-HEIGHT)) (place-UFO (make-posn 20 10) (place-tank (make-tank 28 -3) BACKGROUND)))

; (make-fired (make-posn 20 100) (make-tank 100 3) (make-posn 22 103))
(place-missile (make-posn 22 103) (place-UFO (make-posn 20 100) (place-tank (make-tank 100 3) BACKGROUND)))


