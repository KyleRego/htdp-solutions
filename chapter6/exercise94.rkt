;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise94) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 94

(require 2htdp/image)

(define WIDTH 500)
(define HEIGHT 500)
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define tank (rectangle 40 20 "solid" "blue"))
(define missile (triangle 15 "solid" "red"))
(define UFO (ellipse 40 20 "solid" "green"))

; mockup
(place-image UFO 50 100 (place-image missile 50 400 (place-image tank 50 (- HEIGHT (/ (image-height tank) 2)) BACKGROUND)))