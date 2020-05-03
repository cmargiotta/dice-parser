#lang racket

#lang racket

(provide (contract-out
          [simple-roll (-> is-simple-dice? any)]
          [roll (-> is-dice? any)]
          [is-dice? (-> string? any)]
          [is-simple-dice? (-> string? any)]))

(define dice-regex #px"^(\\s*[+-]?\\s*(-?\\s*\\d+(\\s*d\\s*\\d+)?)+)*$")
(define simple-dice-regex #px"(-?\\d+)d?(\\d*)")

; Roll a dice number times
(define simple-roll
  (case-lambda
    [(number dice) (letrec ([iter-roll (lambda (n lst)
                                         (if (equal? n 0)
                                             (if (empty? lst) '(0) lst)
                                             (iter-roll (- n 1) (list* (random 1 dice) lst))))])
                     (if (= dice 0) '(0) (if (= dice 1) (list number) (map (lambda (n) (* (if (> number 0) 1 -1) n)) (iter-roll (abs number) '())))))]
    [(expr) (let ([parsed (regexp-match simple-dice-regex expr)])
              (simple-roll (string->number (second parsed)) (string->number (last parsed))))]))

; Predicate: does str represent a dice expression?
(define (is-dice? str)
  (case (regexp-match dice-regex str)
    [(#f) #f]
    [else #t]))

; Predicate: does str represent a simple dice expression?
(define (is-simple-dice? str)
  (case (regexp-match simple-dice-regex str)
    [(#f) #f]
    [else #t]))

(struct roll-expr-tree (label children) #:transparent)

; Parses a dice expression
(define (parse-dice-expr expr)
  (let ([expr-list (string-split (string-replace (string-replace expr " " "") "-" ".-") "+")])
        (foldl (lambda (element new-list)
                 (append new-list (string-split element ".")))
               '() expr-list)))
            

; Computes a single dice expression, in format ndX or n (1d6 or 5)
(define (compute-simple-dice-expr expr)
  (let ([parsed (regexp-match simple-dice-regex expr)])
    (if (eq? (string-length (last parsed)) 0)
        (values expr (string->number (second parsed)))
        (letrec ([roll-result (simple-roll (string->number (second parsed)) (string->number (last parsed)))]
              [roll-string (foldl (lambda (element str) (string-append str (number->string (abs element)) ",")) "" roll-result)])
          (values (string-append expr "(" (substring roll-string 0 (- (string-length roll-string) 1)) ")") (foldl + 0 roll-result))))))

; Computes a full parsed expression list
(define (compute-dice-expr expr)
  (letrec ([aux (lambda (expr str tot)
                  (if (empty? expr)
                      (values str tot)
                      (let-values ([(cstr res) (compute-simple-dice-expr (first expr))]
                                   [(op) (if (empty? (rest expr))
                                             ""
                                             (if (eq? (string-ref (second expr) 0) #\-)
                                                 ""
                                                 "+"))])
                        (aux (rest expr) (string-append str cstr op) (+ tot res)))))])
    (aux expr "" 0)))
                
; Rolls a dice expression
(define (roll expr)
  (let ([parsed (parse-dice-expr expr)])
    (compute-dice-expr parsed)))

;;;;;;;;;;;;;;;;;;
TESTS
;;;;;;;;;;;;;;;;;;

(module+ test
  (require rackunit))

(module+ test
  (define-values (str tot) (roll "2d20-1d6")))

(module+ test
  (check-true (list? (simple-roll "5d6")))
  (check-= 5 (length (simple-roll "5d6")) 0))

(module+ test
  (check > tot 0))
