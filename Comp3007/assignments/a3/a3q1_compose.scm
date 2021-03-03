;1
(define square (lambda(x)(* x x)))
(define double (lambda(x)(+ x x)))

(define (compose f g) (lambda (x) (f( g x))))


;2
(define (divisibleBy x) (lambda (n) (= (- n (* (floor (/ n x)) x))  0)))

(define mod3 (divisibleBy 3) )



;3
(define (unshift l x) (cons x l))

(define (get-element items i)
    (if (= i 0)
        (car items)
        (get-element (cdr items) (- i 1))))

(define (newmap fn)
 
    (define (iter prevList l i)
       (if (< i 0)
        l  
        (iter prevList
              (unshift l (fn (get-element prevList i)))
              (- i 1) )))
  
   (lambda (prevList)
    (iter prevList '() (- (length prevList) 1))))

(define double-mapper (newmap (lambda(x)(* x 2))))

;4

(define (newfilter fn)
  (define (filter prevList l i)
 
      (cond ((< i 0)  l)
            (( not (fn (get-element prevList i)))
             (filter prevList (unshift l (get-element prevList i)) (- i 1)))
            (else  (filter prevList l (- i 1)))))
  
  (lambda (prevList) (filter prevList '() ( - (length prevList) 1))))


;5
(define (range a b)
    (if (= a b) (list a)
        (cons a (range (+ a 1) b))))

(define square (lambda (x) (* x x)))

(define filter-not-4 (lambda (filter) (not ((divisibleBy 4) filter))))

(define myfunc (lambda (range)
                ((newmap square)
                 ((newfilter  filter-not-4) range) ))
)
               
(myfunc (range 1 20))