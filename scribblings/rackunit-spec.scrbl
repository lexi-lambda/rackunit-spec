#lang scribble/manual

@(require scribble/eval
          (for-label racket/base
                     racket/function
                     rackunit
                     rackunit/spec))

@title{RackUnit Spec: BDD interface for RackUnit}
@author{@author+email["Alexis King" "lexi.lambda@gmail.com"]}

@defmodule[rackunit/spec]

This library implements forms to assist with writing tests using the style associated with
@hyperlink["https://en.wikipedia.org/wiki/Behavior-driven_development"]{behavior-driven development}
on top of @racketmodname[rackunit].

@(examples
  #:eval ((make-eval-factory '(racket/function rackunit rackunit/spec)))
  (describe "add1"
    (context "given a number"
      (it "increments it by one"
        (check-equal? (add1 0) 1)
        (check-equal? (add1 -5) -4)
        (check-equal? (add1 41) 42)))

    (context "given a non-number"
      (it "throws an exception"
        (check-exn exn:fail:contract?
                   (thunk (add1 "hello"))))))
  (define (broken-fibonacci n)
    (cond [(= n 0) 0]
          [(= n 1) 1]
          [else    (+ (broken-fibonacci (- n 1))
                      (broken-fibonacci (- n 1)))]))
  (describe "broken-fibonacci"
    (context "given a positive integer"
      (it "returns the nth fibonacci number"
        (check-equal? (broken-fibonacci 6) 8)))))

@deftogether[(@defform[(describe description-str body-expr ...+)]
              @defform[(context description-str body-expr ...+)])]{
Used to annotate groups of tests contained within @racket[it] blocks. The @racket[describe] and
@racket[context] forms are identical in behavior, but the @racket[context] form can be used to more
clearly specify that the description refers to a particular condition rather than a form or function
being described.}

@defform[(it description-str body-expr ...+)]{
Like @racket[test-case] from @racketmodname[rackunit], but the description is augmented with
information from the enclosing @racket[describe] and @racket[context] forms.}
