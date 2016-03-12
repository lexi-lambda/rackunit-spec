#lang racket/base

(require racket/stxparam
         rackunit
         (for-syntax racket/base
                     racket/string
                     syntax/parse))

(provide describe it
         (rename-out [describe context]))

(define-syntax-parameter current-descriptions '())

(define-syntax describe
  (syntax-parser
    [(_ descr:str body:expr ...+)
     #`(syntax-parameterize
           ([current-descriptions (cons #,(syntax->datum #'descr)
                                        (syntax-parameter-value #'current-descriptions))])
         body ...)]))

(define-syntax it
  (syntax-parser
    [(_ descr:str body:expr ...+)
     (let ([descrs (reverse (cons (syntax->datum #'descr)
                                  (syntax-parameter-value #'current-descriptions)))])
       (with-syntax ([formatted-descr (string-join
                                       (for/list ([(descr i) (in-indexed (in-list descrs))])
                                         (string-append (make-string (* i 2) #\space) descr))
                                       "\n")])
         #'(test-case formatted-descr body ...)))]))
