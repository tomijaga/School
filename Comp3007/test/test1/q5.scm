(define (stream-cons a b)
	(cons a (delay b)))

(define (seq-starting-from n)
    (stream-cons 1 (seq-starting-from (+ n 1))))