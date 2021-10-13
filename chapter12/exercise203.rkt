;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname exercise203) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

; exercise 201

; LTracks -> List-of-Strings
; returns the list of album titles of the
; list of tracks
(check-expect (select-all-album-titles '()) '())
(check-expect (select-all-album-titles ex-list-tracks) (list "track album" "Parachutes"))
(define (select-all-album-titles tracks)
  (cond
    [(empty? tracks) '()]
    [else (cons
           (track-album (first tracks))
           (select-all-album-titles (rest tracks)))]))

; List-of-Strings -> List-of-Strings
; returns a list containing every element of the original list
; but each element only appearing once
(check-expect (create-set '()) '())
(check-expect (create-set (list "hello" "hello")) (list "hello"))
(define (create-set alos)
  (cond
    [(empty? alos) '()]
    [else (if
           (not-in-set (first alos) (create-set (rest alos)))
           (cons (first alos) (create-set (rest alos)))
           (create-set (rest alos)))]))

; String List-of-Strings -> Boolean
; returns true if the string is not in the list
(check-expect (not-in-set "hello" '()) #true)
(check-expect (not-in-set "hello" (list "hello")) #false)
(check-expect (not-in-set "a" (list "b" "c" "d")) #true)
(check-expect (not-in-set "c" (list "b" "c" "d")) #false)
(define (not-in-set str set)
  (cond
    [(empty? set) #true]
    [else (if (and
           (not (string=? str (first set)))
           (not-in-set str (rest set)))
          #true
          #false)]))

; LTracks -> List-of-Strings
; consumes a list of tracks and produces a list
; of album titles where each album title appears once
(define (select-album-titles/unique tracks)
  (create-set (select-all-album-titles tracks)))

; exercise 202

; String LTracks -> LTracks
; produces a list of tracks which belong to the given album
(check-expect (select-album "Parachutes" '()) '())
(check-expect (select-album "Parachutes" ex-list-tracks) (list extrack2))
(define (select-album alb tracks)
  (cond
    [(empty? tracks) '()]
    [else (if
           (string=? (track-album (first tracks)) alb)
           (cons (first tracks) (select-album alb (rest tracks)))
           (select-album alb (rest tracks)))]))


; exercise 203

; String Date LTracks -> LTracks
; produces a list of tracks that belong to given album
; and have been played after the given date
(check-expect (select-album-date "a" (create-date 2018 0 0 0 0 0) '()) '())
(check-expect (select-album-date "Parachutes"
                                 (create-date 2018 0 0 0 0 0)
                                 ex-list-tracks)
              (list extrack2))
(define (select-album-date alb date tracks)
  (cond
    [(empty? tracks) '()]
    [else (if (and
               (string=? alb (track-album (first tracks)))
               (date>? (track-played (first tracks)) date))
              (cons (first tracks) (select-album-date alb date (rest tracks)))
              (select-album-date alb date (rest tracks)))]))

; Date Date -> Boolean
; determines whether the first date is later than the second
(check-expect (date>? (create-date 2020 0 0 0 0 0) (create-date 2019 0 0 0 0 0)) #true)
(check-expect (date>? (create-date 2020 0 0 0 0 0) (create-date 2020 1 0 0 0 0)) #false)
(check-expect (date>? (create-date 2020 1 2 0 0 0) (create-date 2020 1 0 0 0 0)) #true)
(check-expect (date>? (create-date 2020 0 0 5 0 0) (create-date 2020 0 0 4 0 0)) #true)
(check-expect (date>? (create-date 2020 0 0 0 2 0) (create-date 2020 0 0 0 7 0)) #false)
(check-expect (date>? (create-date 2020 0 0 0 0 0) (create-date 2020 0 0 0 0 1)) #false)
(check-expect (date>? (create-date 2020 0 0 0 0 1) (create-date 2020 0 0 0 0 0)) #true)
(check-expect (date>? (create-date 2020 0 0 5 0 0) (create-date 2020 0 0 0 6 6)) #true)
(define (date>? d1 d2)
    (if
     (not (= (date-year d1) (date-year d2)))
     (> (date-year d1) (date-year d2))
     (if
      (not (= (date-month d1) (date-month d2)))
      (> (date-month d1) (date-month d2))
      (if
       (not (= (date-day d1) (date-day d2)))
       (> (date-day d1) (date-day d2))
       (if
        (not (= (date-hour d1) (date-hour d2)))
        (> (date-hour d1) (date-hour d2))
        (if
         (not (= (date-minute d1) (date-minute d2)))
         (> (date-minute d1) (date-minute d2))
         (> (date-second d1) (date-second d2))))))))

    