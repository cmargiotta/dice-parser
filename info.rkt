#lang info

(define collection "dice-parser")

(define version "0.0.1")

(define pkg-desc "A parser for dice expressions like \"1d6-1d4+5\".")

(define pkg-authors '("car.margiotta@icloud.com"))

(define deps '("base"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
