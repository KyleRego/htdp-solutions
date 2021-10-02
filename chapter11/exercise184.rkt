;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise184) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 184

(list (string=? "a" "b") #false) ; (list #false #false)
(list (+ 10 20) (* 10 20) (/ 10 20)) ; (list 30 200 0.5)
(list "dana" "jane" "mary" "laura") ; (list "dana" "jane" "mary" "laura")