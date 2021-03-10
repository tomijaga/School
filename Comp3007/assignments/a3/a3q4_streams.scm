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

(define (list->stream list)
  (if (null? list) '()
      (stream-cons (car list) (list->stream (cdr list)))))


;2
(define (stream->list strm n)
  (define (iter list i)
    (if (or (null? list) (= i n) )
        '()
        (cons (stream-car list) (iter (stream-cdr list) (+ i 1)))))
  (iter strm 0))
  
(define strm (list->stream '(1 2 3 4 5 6 7 8 9 10)))

strm

(stream->list strm 3 )

;3

(define (factorial-iter)
  (define (calc-fac i prev)
    (cond ((= i 0) (stream-cons 1  (calc-fac (+ i 1) 1) ))
          (else (stream-cons prev  (calc-fac (+ i 1) (* i prev)) ) )))
   (calc-fac 0 0))

(define factorials
  (factorial-iter))
        
factorials

(stream->list factorials 10) 

;4
(define (prng seed)
  (define (iter xn)
    (stream-cons xn (iter (modulo (+ (* 22695477  xn) 1) (expt 2 32)))))
  (iter seed))

(stream->list (prng 3) 5)