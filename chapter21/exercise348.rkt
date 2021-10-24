;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname exercise348) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; exercise 348

(define-struct AND [left right])
(define-struct OR [left right])
(define-struct NOT [right])
; a Bool is one of:
; - #true
; - #false
; - (make-AND Bool Bool)
; - (make-OR Bool Bool)
; - (make-NOT Bool)


(check-expect (eval-bool-expression (make-AND #true #true)) #true)
(check-expect (eval-bool-expression (make-AND #false #false)) #false)
(check-expect (eval-bool-expression (make-AND #true #false)) #false)
(check-expect (eval-bool-expression (make-AND #false #false)) #false)
(check-expect (eval-bool-expression (make-AND (make-AND #true #true) #true)) #true)
(check-expect (eval-bool-expression (make-OR #true #false)) #true)
(check-expect (eval-bool-expression (make-OR #false #false)) #false)
(check-expect (eval-bool-expression (make-OR (make-AND #true #true) #false)) #true)
(check-expect (eval-bool-expression (make-NOT #true)) #false)
(check-expect (eval-bool-expression (make-NOT #false)) #true)
; Bool -> Bool
(define (eval-bool-expression bool)
  (cond
    ([AND? bool] (and
                  (eval-bool-expression (AND-left bool))
                  (eval-bool-expression (AND-right bool))))
    ([OR? bool] (or
                 (eval-bool-expression (OR-left bool))
                 (eval-bool-expression (OR-right bool))))
    ([NOT? bool] (not
                  (eval-bool-expression (NOT-right bool))))
    
    (else bool)))


    