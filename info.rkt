#lang info

(define collection "rackunit")
(define version "0.1")

(define scribblings
  '(["scribblings/rackunit-spec.scrbl"]))

(define deps
  '("base"
    "rackunit-lib"))
(define build-deps
  '("racket-doc"
    "rackunit-doc"
    "scribble-lib"))
