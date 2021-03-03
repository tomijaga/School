(define (unshift l x) (cons x l))

(define (get-element items i)
    (if (= i 0)
        (car items)
        (get-element (cdr items) (- i 1))))

(define (split l)
  (define (iter i oddl evenl)
    (cond
      ((< i 0) (begin (cons evenl oddl)))
      ((= (modulo i 2) 0) (begin (display (cons evenl  oddl)) (display "\n" )(iter  (- i 1) oddl (unshift evenl (get-element l i)))))
      (else (iter  (- i 1) (unshift oddl (get-element l i)) evenl)))
    )
  (iter (- (length l) 1) '() '() ))