;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise109) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 109

(require 2htdp/image)
(require 2htdp/universe)

; ExpectsToSee is one of:
; – AA
; – BB
; – DD 
; – ER 
 
(define AA "start, expect an 'a'")
(define BB "expect 'b', 'c', or 'd'")
(define DD "finished")
(define ER "error, illegal key")

; ExpectsToSee -> Image
(check-expect (render AA) (overlay (text AA 12 "black")
         (rectangle 100 100 "solid" "white")))
(check-expect (render BB) (overlay (text BB 12 "black")
         (rectangle 100 100 "solid" "yellow")))
(check-expect (render DD) (overlay (text DD 12 "black")
         (rectangle 100 100 "solid" "green")))
(check-expect (render ER) (overlay (text ER 12 "black")
         (rectangle 100 100 "solid" "red")))
(define (render ets)
  (cond
    [(string=? ets AA)(overlay (text AA 12 "black")
                               (rectangle 100 100 "solid" "white"))]
    [(string=? ets BB)(overlay (text BB 12 "black")
                               (rectangle 100 100 "solid" "yellow"))]
    [(string=? ets DD)(overlay (text DD 12 "black")
                               (rectangle 100 100 "solid" "green"))]
    [(string=? ets ER)(overlay (text ER 12 "black")
                               (rectangle 100 100 "solid" "red"))]))

; ExpectsToSee -> ExpectsToSee
; the clock-tick handler, just returns the current state
(define (clock-handler ets)
  ets)

; ExpectsToSee KeyEvent -> ExpectsToSee
; the key event handler
(check-expect (key-handler AA "a") BB)
(check-expect (key-handler AA "b") ER)
(check-expect (key-handler BB "b") BB)
(check-expect (key-handler BB "c") BB)
(check-expect (key-handler BB "a") ER)
(check-expect (key-handler BB "d") DD)
(define (key-handler ets ke)
  (cond
    [(string=? ets AA)
     (cond
       [(string=? ke "a") BB]
       [else ER])]
    [(string=? ets BB)
     (cond
       [(or (string=? ke "b") (string=? ke "c"))
        BB]
       [(string=? ke "d") DD]
       [else ER])]))
       

(define (main ets)
  (big-bang ets
    (on-tick clock-handler)
    (to-draw render)
    (on-key key-handler)))

(main AA)