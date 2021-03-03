
(define (unshift l x) (cons x l))

(define (get-element items i)
    (if (= i 0)
        (car items)
        (get-element (cdr items) (- i 1))))

(define (collapse l)
  (define (iter newl i counter)
    
    (cond ((< i 0) (begin  newl))
          ((= (length newl) 0) (iter (unshift newl (get-element l i)) (- i 1) counter))
          ((not (= (get-element l i) (get-element l (+ i 1))))
              (begin (display i ) (display newl) (display "\n") (iter (unshift newl (get-element l i)) (- i 1) (+ counter 1))))
        (else (iter newl (- i 1) counter))))
  (iter '() (- (length l) 1) 0))