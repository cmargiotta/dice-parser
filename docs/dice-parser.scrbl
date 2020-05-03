#lang scribble/manual

@title{dice-parser}
@author[(author+email @elem{Carmine Margiotta}
                      "car.margiotta@icloud.com")]

@defmodule[dice-parser]

dice-parser is a tool for parsing and rolling dice expression.

A simple dice expression is in format
@racket[ndX] where @racket[n] and @racket[X] are natural numbers or, simply, @racket[n].
Simple dice expressions can be composed in full dice expressions with @racket[+] and @racket[-] operators.

@section{Parsing simple dice expressions}
A simple dice expression can be parsed using
@codeblock|{
            > (simple-roll expression)
  }|

For example:
@codeblock|{
   > (define expr "6d6")
   > (simple-roll expr)
   '(6 5 3 5 2 2)
   }|

@section{Parsing full dice expressions}
A full dice expression can be parsed using
@codeblock|{
            > (roll expression)
  }|

For example:
@codeblock|{
   > (define expr "6d6+1d20-4")
   > (roll expr)
   "6d6(6,5,3,5,2,2)+1d20(15)-4"
   34
   }|


