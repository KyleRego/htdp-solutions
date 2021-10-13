;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise200) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/itunes)

(define ITUNES-LOCATION "itunes.xml")
 
; LTracks
;(define itunes-tracks
;  (read-itunes-as-tracks ITUNES-LOCATION))

; exercise 199

(define exdate1 (create-date 2021 10 3 10 17 30))
(define exdate2 (create-date 2015 5 25 23 40 0))
(define exdate3 (create-date 2020 0 0 0 0 0))

(define extrack1 (create-track "track title"
                               "track artist"
                               "track album"
                               500 ; playing time in milliseconds
                               5 ; position within the album
                               exdate2 ; date it was added
                               20 ; how often it was played
                               exdate1)) ; date it was last played

(define extrack2 (create-track "Don't Panic"
                               "Coldplay"
                               "Parachutes"
                               500
                               1
                               exdate2
                               20
                               exdate3))

(define ex-list-tracks (list extrack1 extrack2))

; exercise 200

; LTracks -> N
; computes the total play time of the list of tracks
(check-expect (total-time '()) 0)
(check-expect (total-time ex-list-tracks) (* 500 40))
(define (total-time tracks)
  (cond
    [(empty? tracks) 0]
    [else (+ (time (first tracks)) (total-time (rest tracks)))]))

; Track -> N
; computes the total time played of the track
(define (time 1track)
  (*
   (track-time 1track)
   (track-play# 1track)))