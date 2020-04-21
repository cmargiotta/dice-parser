#lang racket

(require "core.rkt")

(provide roll)
(provide simple-roll)
(provide is-dice?)
(provide is-simple-dice?)

(module+ test
  (require rackunit))

(module+ test
  (define-values (str tot) (roll "2d20-1d6")))

(module+ test
  (check-true (list? (simple-roll "5d6")))
  (check-= 5 (length (simple-roll "5d6")) 0))

(module+ test
  (check > tot 0))