;1

(define-syntax stream-cons
  (syntax-rules ()
    ((stream-cons a b ) (cons a (delay b)))))

(define (stream-car strm)
  (car strm))

(define (stream-cdr strm )
  (force (cdr strm)))

(define (stream-range a b)
  (if (> a b)
      '()
      (stream-cons a (stream-range (+ a 1) b))))

;Purpose: Makes a stream from a given list
;@params list =  list to make stream from
(define (list->stream list)
  (if (null? list) '()
      (stream-cons (car list) (list->stream (cdr list)))))

(display "Testing: 4a")(newline)

(display "Testing: list->stream")(newline)
(display "(list->stream '(2 3 4 5)):")(newline)
   (display "Expected: (2 . #<promise>)")(newline)
   (display "Actual: ")(list->stream '(2 3 4 5))(newline)

(display "(list->stream '(5 10)):")(newline)
   (display "Expected: (5 . #<promise>)")(newline)
   (display "Actual: ")(list->stream '(5 10))(newline)

;2
;Purpose: Makes a list from the first n items of the given stream
;@params strm = Given stream to make list from;
;@params n = max length of list
(define (stream->list strm n)
  (define (iter list i)
    (if (or (null? list) (= i n) )
        '()
        (cons (stream-car list) (iter (stream-cdr list) (+ i 1)))))
  (iter strm 0))
  
(define strm (list->stream '(1 2 3 4 5 6 7 8 9 10)))

strm

(display "Testing: 4b")(newline)

(display "Testing: stream->list")(newline)
(display "(stream->list strm 3):")(newline)
   (display "Expected: (1 2 3)")(newline)
   (display "Actual: ")(stream->list strm 3)(newline)

(display "Testing: stream->list")(newline)
(display "(stream->list strm 5):")(newline)
   (display "Expected: (1 2 3 4 5)")(newline)
   (display "Actual: ")(stream->list strm 5)(newline)

;3
;Purpose: iteration for calculating factorials
(define (factorial-iter)
  (define (calc-fac i prev)
    (cond ((= i 0) (stream-cons 1  (calc-fac (+ i 1) 1) ))
          (else (stream-cons prev  (calc-fac (+ i 1) (* i prev)) ) )))
   (calc-fac 0 0))

(define factorials
  (factorial-iter))
        
factorials

(display "Testing: 4c")(newline)

(display "Testing: stream->list")(newline)
(display "(stream->list factorials 10) :")(newline)
   (display "Expected: (1 1 1 2 6 24 120 720 5040 40320)")(newline)
   (display "Actual: ")(stream->list factorials 10) (newline)

(display "Testing: stream->list")(newline)
(display " (stream->list factorials 5) :")(newline)
   (display "Expected: (1 1 1 2 6)")(newline)
   (display "Actual: ") (stream->list factorials 5) (newline)

;4
;Purpose: A pseudo-random number generator 
;@params seed: number to start with
(define (prng seed)
  (define (calc-prng seed)
    (modulo (+ (* 22695477  seed) 1) (expt 2 32)))
  (define (iter xn)
    (stream-cons (/ xn (expt 2 32)) (iter (calc-prng xn ))))
  (iter (calc-prng seed)))

(stream->list (prng 3) 5)

(display "Testing: 4d")(newline)

(display "Testing: stream->list")(newline)
(display "(stream->list (prng 3) 5) :")(newline)
   (display "Expected: (2127701/134217728 2127778593/4294967296 2144805355/2147483648 3069919055/4294967296 330583/1073741824)")(newline)
   (display "Actual: ")(stream->list (prng 3) 5) (newline)

(display "Testing: stream->list")(newline)
(display " (stream->list (prng 10) 2) :")(newline)
   (display "Expected: (226954771/4294967296 261020479/268435456)")(newline)
   (display "Actual: ") (stream->list (prng 10) 2) (newline)


;5 
;Purpose: converts numbers between 0-1 to a proportional whole number between min-max
;@params val = number to convert
;@params min = minimum value
;@params max = maximum value

(define (set-Min-Max val min max) 
  (+ (floor (* val (+ (- max min ) 1))) min))

;Purpose: Returns a Stream of random numbers
(define(random-int r min max)
       (stream-cons  (set-Min-Max (stream-car r) min max)  (random-int (stream-cdr r) min max)))

(display "Testing: 4e")(newline)

(display "Testing: random-int")(newline)
(display "(stream->list (random-int (prng 3) 3 13) 3) :")(newline)
   (display "Expected: (3 8 13)")(newline)
   (display "Actual: ")(stream->list (random-int (prng 3) 3 13) 3) (newline)

(display "(stream->list (random-int (prng 7) 3 13) 3) :")(newline)
   (display "Expected: (3 8 10)")(newline)
   (display "Actual: ")(stream->list (random-int (prng 7) 3 13) 3) (newline)

(display "(stream->list (random-int (prng 3) 10 20) 5):")(newline)
   (display "Expected: (10 15 20 17 10)")(newline)
   (display "Actual: ")(stream->list (random-int (prng 3) 10 20) 5)(newline)
