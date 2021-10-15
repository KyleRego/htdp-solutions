;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise262) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 262

; Number -> [List-of [List-of Number]]
; makes identity matrix of size n
(check-expect (identityM 1) (list (list 1)))
(check-expect (identityM 3) (list (list 1 0 0)
                                  (list 0 1 0)
                                  (list 0 0 1)))
(define (identityM n)
  (local ((define cols n)
          ; make one row of the identity matrix 
          (define (make-row cols n)
            (local ((define x (if (= n cols) 1 0)))
              (cond
                [(= cols 1) (cons x '())]
                [else (cons x
                            (make-row (- cols 1) n))])))
          ; make a portion of the entire identity matrix
          (define (make-matrix cols rows)
            (cond
              [(= rows 1) (list (make-row cols rows))]
              [else (cons
                     (make-row cols rows)
                     (make-matrix cols (- rows 1)))])))
    (cond
      [(= n 1) (list (make-row cols n))]
      [else (cons
             (make-row cols n)
             (make-matrix cols (- n 1)))])))





  