;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise100) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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




; exercise 97

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



; exercise 98

; SIGS -> Boolean
; returns #true if the missile is in proximity to the UFO
; or the UFO reaches the ground
(check-expect (si-game-over? (make-aim (make-posn (/ WIDTH 2) 4) (make-tank 20 2))) #true)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 20 2) (make-posn 48 48))) #true)
(check-expect (si-game-over? (make-fired (make-posn 50 50) (make-tank 20 2) (make-posn 22 22))) #false)
(define (si-game-over? s)
  (cond
    [(aim? s)  (within-distance (aim-ufo s) (make-posn (posn-x (aim-ufo s)) 0))]
    [(fired? s) (or
                      (within-distance (fired-ufo s) (make-posn (posn-x (fired-ufo s)) 0))
                      (within-distance (fired-ufo s) (fired-missile s)))]))
    
; Posn Posn -> Boolean
; returns #true if two Posns are within DISTANCE-TO-HIT
; of each other
(check-expect (within-distance (make-posn 0 0) (make-posn 0 4.9)) #true)
(check-expect (within-distance (make-posn 0 0) (make-posn 0 5)) #true)
(check-expect (within-distance (make-posn 0 0) (make-posn 0 5.1)) #false)
(define (within-distance pos1 pos2)
  (>= DISTANCE-TO-HIT (distance pos1 pos2)))

; Posn Posn -> Number
; returns the distance between two Posns
(check-expect (distance (make-posn 0 0) (make-posn 3 4)) 5)
(check-expect (distance (make-posn 1 1) (make-posn 1 2)) 1)
(define (distance pos1 pos2)
  (sqrt (+ (sqr (- (posn-x pos1) (posn-x pos2))) (sqr(- (posn-y pos1) (posn-y pos2))) )))




; exercise 99

; SIGS -> SIGS
; updates SIGS such that the tank and missile move
; according to their velocities and the UFO moves
; a random amount to the left or right in the interval [0, 1)
(define (si-move s)
  (cond
    [(= (random 2) 1) (si-move-proper s (random 3))]
    [(= (random 1) 0) (si-move-proper s (* -1 (random 3)))]))

; SIGS Number -> SIGS
(check-expect (si-move-proper (make-aim (make-posn 50 50) (make-tank 20 2)) 0.5) (make-aim (make-posn 50.5 (+ 50 UFO-DELTA-Y)) (make-tank 22 2)))
(check-expect (si-move-proper
               (make-fired (make-posn 50 50) (make-tank 20 -2) (make-posn 25 25)) 0.7)
              (make-fired (make-posn 50.7 (+ 50 UFO-DELTA-Y)) (make-tank 18 -2) (make-posn 25 (+ 25 MISSILE-DELTA-Y))))
(define (si-move-proper s delta)
  (cond
    [(aim? s)
     (make-aim
      (make-posn (+ (posn-x (aim-ufo s)) delta) (+ (posn-y (aim-ufo s)) UFO-DELTA-Y))
      (make-tank (+ (tank-loc (aim-tank s)) (tank-vel (aim-tank s))) (tank-vel (aim-tank s))))]
    [(fired? s)
     (make-fired
      (make-posn (+ (posn-x (fired-ufo s)) delta) (+ (posn-y (fired-ufo s)) UFO-DELTA-Y))
      (make-tank (+ (tank-loc (fired-tank s)) (tank-vel (fired-tank s))) (tank-vel (fired-tank s)))
      (make-posn (posn-x (fired-missile s)) (+ (posn-y (fired-missile s)) MISSILE-DELTA-Y)))]))





; exercise 100

; SIGS KeyEvent -> SIGS
; key-event handler for the UFO game
; pressing the left arrow gives the tank a velocity of -2
; pressing the right arrow gives the tank a velocity of +2
; pressing the spacebar fires the missile
(check-expect (si-control (make-aim (make-posn 20 20) (make-tank 20 2)) "left") (make-aim (make-posn 20 20) (make-tank 20 -2)))
(check-expect (si-control (make-aim (make-posn 20 20) (make-tank 20 -2)) "right") (make-aim (make-posn 20 20) (make-tank 20 2)))
(check-expect (si-control (make-aim (make-posn 20 20) (make-tank 20 -2)) " ") (make-fired (make-posn 20 20) (make-tank 20 -2) (make-posn 20 (- HEIGHT TANK-HEIGHT))))
(check-expect (si-control (make-fired (make-posn 50 50) (make-tank 20 2) (make-posn 10 10)) "left") (make-fired (make-posn 50 50) (make-tank 20 -2) (make-posn 10 10)))
(check-expect (si-control (make-fired (make-posn 40 40) (make-tank 20 -2) (make-posn 20 20)) "right") (make-fired (make-posn 40 40) (make-tank 20 2) (make-posn 20 20)))
(define (si-control s ke)
  (cond
    [(aim? s)
     (cond
       [(string=? ke "left") (make-aim (aim-ufo s) (make-tank (tank-loc (aim-tank s)) -2))]
       [(string=? ke "right") (make-aim (aim-ufo s) (make-tank (tank-loc (aim-tank s)) 2))]
       [(string=? ke " ") (make-fired (aim-ufo s) (aim-tank s) (make-posn (tank-loc (aim-tank s)) (- HEIGHT TANK-HEIGHT)))]
       [else s])]
    [(fired? s)
     (cond
       [(string=? ke "left") (make-fired (fired-ufo s) (make-tank (tank-loc (fired-tank s)) -2) (fired-missile s))]
       [(string=? ke "right") (make-fired (fired-ufo s) (make-tank (tank-loc (fired-tank s)) 2) (fired-missile s))]
       [else s])]))



; SIGS -> Image
; renders the Image representing the state of the UFO game
(define (render s)
  (cond
    [(aim? s) (place-UFO (aim-ufo s) (place-tank (aim-tank s) BACKGROUND))]
    [(fired? s) (place-missile (fired-missile s) (place-UFO (fired-ufo s) (place-tank (fired-tank s) BACKGROUND)))]))






(define (si-main s)
  (big-bang s
    (to-draw render)
    (on-tick si-move)
    (on-key si-control)
    (stop-when si-game-over?)))

(si-main (make-aim (make-posn 10 (/ WIDTH 2)) (make-tank 20 2)))