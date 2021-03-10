;1
(define (repeat x n)
 ( define (iter l i)
    (if ( = i n)
        l
        (iter (cons x l) (+ i 1))))
  (iter '() 0))

(repeat 'a 5)

;2
(define (get-element l i)
    (if (= i 0)
        (car l)
        (get-element (cdr l) (- i 1)))
     )

(define (unshift l val)
  (cons val l))

(define (pop l)
  (define (recc newL i)
    (if (>= (length newL) (- (length l) 1))
        newL
        (recc (cons (get-element l (- (length l) (+ i 2))) newL)  (+ i 1))))
  (recc '() 0))

(define (cp-last-element from to)
  (cons (get-element from (- (length from) 1)) to))

(define (alternative listA listB)
  (define (iter newA newB combinedList i)
    (define d-A (display newA))
     (define d-B (display newB))
    (cond ((and (> (length newA) 0 ) ( > (length newB) 0))
          (if ( = (modulo i 2) 0)
             (begin (display "cond 1\n" ) (iter (pop newA) newB  (cp-last-element newA combinedList) (+ i 1)))
             (begin (display "cond 1\n" ) (iter newA (pop newB) (cp-last-element newB combinedList) (+ i 1)))))
          ((> (length newA) 0)  (begin (display "cond 2\n" ) d-A (iter (pop newA) newB  (cp-last-element newA combinedList) (+ i 1))))
          ((> (length newB) 0)  (begin (display "cond 3\n" ) d-B (iter newA (pop newB) (cp-last-element newB combinedList) (+ i 1))))
          (else combinedList) ))
  (iter listA listB '() 0))

(alternative '(1 3 ) '(0 2 4 6 8))

;3
(define (count l x)
  (define (recc newl i)
    (cond ((not (> (length newl) 0)) i)
          ((equal? x (car newl))  (recc (cdr newl) (+ i 1)))
          (else (recc (cdr newl) i))))
  (recc l 0))

