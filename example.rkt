#lang racket
(define b `((1 0 0) (0 1 0) (0 0 1)))

;; returns item
(define (get-at list index)
    (if (zero? index)
        (car list) ;; index = 0 return
        (get-at (cdr list) (-index 1))))

;; returns value in row/column
;; get cell
(define (get-cell board row col)
    (get-at (get-at board row) col))

(define win-conditions '(
                            ((0 0) (0 1) (0 2))
                            ((1 0) (1 1) (1 2))
                            ((2 0) (2 1) (2 2))
                            ((0 0) (1 0) (2 0))
                            ((0 1) (1 1) (2 1))
                            ((0 2) (1 2) (2 2))
                            ((0 0) (1 1) (2 2))
                            ((2 0) (1 1) (0 2))
))

(define (player-wins-any board player possible-wins)
    (if (null? possible-wins) #f
        (or
        (player-at-all-cells board player (car possible-wins))
        (player-wins-any board player (cdr possible-wins)))))

(define (player-at-all-cells board player cells)
    (if (null? cells) #t
        (and
            (= (get-cell board (car (car cells)) (cadr (car cells))) player)
            (player-at-all-cells board player (cdr cells)))))