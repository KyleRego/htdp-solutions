;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise206) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 205

(require 2htdp/itunes)

(define ITUNES-LOCATION "itunes.xml")
 
; LLists
(define list-tracks
  (read-itunes-as-lists ITUNES-LOCATION))

list-tracks

(define song1
  (list
   (list "Track ID" 1)
   (list "Name" "Parachutes")
   (list "Artist" "Coldplay")
   (list "Album" "Parachutes")
   (list "Date Added" (create-date 2020 0 0 0 0 0))
   (list "Play Count" 20)
   (list "Played Once" #true)))

(define song2
  (list
   (list "Track ID" 2)
   (list "Name" "Don't Panic")
   (list "Artist" "Coldplay")
   (list "Album" "Parachutes")
   (list "Date Added" (create-date 2020 0 0 0 0 0))
   (list "Play Count" 15)
   (list "Played Once" #true)))

(define song3
  (list
   (list "Track ID" 3)
   (list "Name" "Yellow")
   (list "Artist" "Coldplay")
   (list "Album" "Parachutes")
   (list "Date Added" (create-date 2020 0 0 0 0 0))
   (list "Play Count" 13)
   (list "Played Once" #true)))

(define list-songs (list song1 song2 song3))

; exercise 206

; String LAssoc Any -> Association
; produces the first Association whose
; first item is equal to key, if not found returns
; the value given as default
(check-expect (find-association "foo bar" '() "default")
              "default")
(check-expect (find-association "Track ID" song3 "default")
              (list "Track ID" 3))
(check-expect (find-association "Played Once" song3 "default")
              (list "Played Once" #true))

(define (find-association key song default)
  (cond
    [(empty? song) default]
    [else (if
           (string=? key (first (first song)))
           (first song)
           (find-association key (rest song) default))]))