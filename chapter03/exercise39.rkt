;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise39) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; exercise 39

(define WHEEL-RADIUS 10)
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define CAR-BODY (rectangle (* 4 WHEEL-RADIUS) (* 2 WHEEL-RADIUS) "solid" "red"))
(define HALF-CAR (overlay/offset CAR-BODY (* 2 WHEEL-RADIUS) (* 1 WHEEL-RADIUS) WHEEL))
(define CAR (overlay/offset HALF-CAR (* -2.4 WHEEL-RADIUS) (* 0.6 WHEEL-RADIUS) WHEEL))

