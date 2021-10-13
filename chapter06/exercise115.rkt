;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise115) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 115

; Any -> Boolean
; is the given value an element of TrafficLight
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))

(define (light=?-message str)
  (error (string-append "given " str " was not a TrafficLight")))
 
; Any Any -> Boolean
; are the two values elements of TrafficLight and, 
; if so, are they equal
 
(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)
(check-error (light=? "hello" "world")
              "Both a-value and another-value were not elements of TrafficLight")
(check-error (light=? "hello" "red")
             "given a-value was not a TrafficLight")
(check-error (light=? "green" "world")
             "given another-value was not a TrafficLight")

(define (light=? a-value another-value)
  (cond
    [(and (light? a-value) (light? another-value))
      (string=? a-value another-value)]
    [(and (boolean=? (light? a-value) #false) (boolean=? (light? another-value) #false))
      (error "Both a-value and another-value were not elements of TrafficLight")]
    [(boolean=? (light? a-value) #false) (light=?-message "a-value")]
    [(boolean=? (light? another-value) #false) (light=?-message "another-value")]))
    