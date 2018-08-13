#lang racket

(define (maximo lst)
  (cond
    [(empty? (rest lst))
     (first lst)]
    [(> (first lst) (maximo (rest lst)))
     (first lst)]
    [else (maximo (rest lst))]))

(module+ test
  (require rackunit)
  (check-equal? (maximo (list 5 4 13 0 9)) 13)
  (check-equal? (maximo (list 5 4 0 9)) 9)
  (check-equal? (maximo (list 5 4 0)) 5)
  (check-equal? (maximo (list 4)) 4))
