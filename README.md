# dice-parser

dice-parser is a tool for parsing and rolling dice expression.

A simple dice expression is in format 
`ndX` where `n` and `X` are natural numbers or, simply, `n`.

Simple dice expressions can be composed in full dice expressions with `+` and `-` operators.

## Parsing simple dice expressions
A simple dice expression can be parsed using
```racket
> (simple-roll expression)
```

For example:
```racket
> (define expr "6d6")
> (simple-roll expr)
'(6 5 3 5 2 2)
```

## Parsing full dice expressions
A full dice expression can be parsed using
```racket
> (roll expression)
```

For example:
```racket
> (define expr "6d6+1d20-4")
> (roll expr)
"6d6(6,5,3,5,2,2)+1d20(15)-4"
34
```
