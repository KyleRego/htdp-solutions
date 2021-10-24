;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise360) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 360

(define-struct add [left right])
(define-struct mul [left right])
(define-struct fun [name expression])
; A BSL-fun-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-fun-expr BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)
; - (make-fun Symbol BSL-fun-expr)

(define-struct fun-def [name parameter body])
; A BSL-fun-def is a structure:
;    (make-fun-def Symbol Symbol BSL-fun-expr)
; interpretation represents
; (define (name parameter) body)

; A BSL-da-all is a [List-of Definition]
; An Definition is one of:
; - (cons Symbol (cons Number '())
; - BSL-fun-def

(define f (make-fun-def 'f 'x (make-add 3 'x)))
(define g (make-fun-def 'g 'y (make-fun 'f (make-mul 2 'y))))
(define h (make-fun-def 'h 'v (make-add (make-fun 'f 'v) (make-fun 'g 'v))))

(define da-fgh (list
                (cons 'x (cons 5 '()))
                f
                (cons 'y (cons 7 '()))
                g
                h))


; Symbol BSL-da-all -> Number
; produces the representation of a constant
; definition whose name is x if it exists in da
(check-expect (lookup-con-def 'x da-fgh) 5)
(check-expect (lookup-con-def 'y da-fgh) 7)
(check-error (lookup-con-def 'z da-fgh) "no such constant definition found")
(define (lookup-con-def x da)
  (local (; Symbol BSL-da-all -> [Maybe Number]
           (define (lookup-con-def-helper x da)
             (cond
               [(empty? da) #false]
               [else
                (if
                 (fun-def? (first da))
                 (lookup-con-def x (rest da))
                 (if
                  (equal? (first (first da)) x)
                  (second (first da))
                  (lookup-con-def x (rest da))))]))
           (define result (lookup-con-def-helper x da)))
    (if
     (equal? result #false)
     (error "no such constant definition found")
     result)))


; Symbol BSL-da-all -> BSL-fun-def
; produces the representation of a function definition
; whose name is f if it exists in da
(check-expect (lookup-fun-def 'g da-fgh) g)
(check-error (lookup-fun-def 'x da-fgh) "function not found")
(define (lookup-fun-def f da)
  (local (; Symbol BSL-da-all -> [Maybe BSL-fun-def]
          (define (lookup-fun-def-helper f da)
            (cond
              [(empty? da) #false]
              [else
               (if
                (and
                 (fun-def? (first da))
                 (equal? (fun-def-name (first da)) f))
                (first da)
                (lookup-fun-def-helper f (rest da)))]))
          (define result (lookup-fun-def-helper f da)))
    (if
     (false? result)
     (error "function not found")
     result)))
          

          

        