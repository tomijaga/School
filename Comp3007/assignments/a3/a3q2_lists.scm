;1
;Purpose: return a list of the n numbers of the element x;
;@params n: number of element in list
;@params x: element to repeat
(define (repeat x n)
 ( define (iter l i)
    (if ( = i n)
        l
        (iter (cons x l) (+ i 1))))
  (iter '() 0))

(repeat 'a 5)

(display "Testing: 2a")(newline)

(display "Testing: repeat")(newline)
(display "(repeat 'a 5):")(newline)
   (display "Expected:  (a a a a a)")(newline)
   (display "Actual: ")(repeat 'a 5)(newline)

(display "(repeat 25 5):")(newline)
   (display "Expected:  (25 25 25 25 25)")(newline)
   (display "Actual: ")(repeat 25 5)(newline)

   (display "(repeat 100 3):")(newline)
   (display "Expected:  (100 100 100)")(newline)
   (display "Actual: ")(repeat 100 1)(newline)

;2
;Purpose: merge two lists together alternating the elements in from two lists
;@params l1 = list 1
;@params l2 = list 2
(define (alternate l1 l2)
  (cond ((and (null? l1) (null? l2)) '())
        ((null? l1 ) (cons  (car l2) (alternate l1 (cdr l2))))
        ((null? l2 ) (cons (car l1)  (alternate (cdr l1) l2)))
        (else (append (list (car l1) (car l2))  (alternate (cdr l1) (cdr l2))))))

(alternate '(0 0 0 0) '(1 1 1 1 1 1))

(display "Testing: 2b")(newline)

(display "Testing: alternate")(newline)
(display "(alternate '(0 0 0 0) '(1 1 1 1 1 1)):")(newline)
   (display "Expected:  (0 1 0 1 0 1 0 1 1 1)")(newline)
   (display "Actual: ")(alternate '(0 0 0 0) '(1 1 1 1 1 1))(newline)

(display "(alternate '(1 3) '(2 4)):")(newline)
   (display "Expected:  (1 2 3 4)")(newline)
   (display "Actual: ")(alternate '(1 3) '(2 4))(newline)

(display "(alternate '() '(1 2 3 4)):")(newline)
   (display "Expected:  (1 2 3 4)")(newline)
   (display "Actual: ")(alternate '() '(1 2 3 4))(newline)


;3
;Purpose: Count the number of time the element (x shows up in list)
;@params l = list to check
;@params x : The element to count 
(define (count x l)
  (define (recc newl i)
    (cond ((not (> (length newl) 0)) i)
          ((equal? x (car newl))  (recc (cdr newl) (+ i 1)))
          (else (recc (cdr newl) i))))
  (recc l 0))

(display "Testing: 2c")(newline)

(display "Testing: count")(newline)
(display "(count 3 '(1 4 3 6 2 3 3 1 4 3 5 7)):")(newline)
   (display "Expected:  4")(newline)
   (display "Actual: ")(count 3 '(1 4 3 6 2 3 3 1 4 3 5 7))(newline)

(display "(alternate '(1 3) '(2 4)):")(newline)
   (display "Expected:  (1 2 3 4)")(newline)
   (display "Actual: ")(alternate '(1 3) '(2 4))(newline)

(display "(count 'b '(4 b a 3 2 c b 1 b 2 d a)):")(newline)
   (display "Expected:  3")(newline)
   (display "Actual: ")(count 'b '(4 b a 3 2 c b 1 b 2 d a))(newline)


(display "(count 'b '(b b b)):")(newline)
   (display "Expected:  3")(newline)
   (display "Actual: ")(count 'b '(b b b))(newline)


;4

;Purpose: Look for the tuple that has the largest element at index 1
;@params t1 = number
;@params t2= number
;returns the largest number's tuple
(define (max-t t1 t2)
  (if (>= (cadr t1)(cadr t2))
      t1
      t2))

;Purpose: Look for the element that appears the most in a list
(define (mode l)
  (define (iter cmp l pointer tuple)
    (cond ((null? l) (max-t tuple (if(null?  pointer)
                                     tuple
                                     (iter (car pointer) (cdr pointer) (cdr pointer )  (list ( car pointer) 0)))))
          ((eq? cmp (car l))  (iter cmp (cdr l) pointer   ( list (car tuple) (+ (cadr tuple) 1) ))  )
          (else (iter cmp (cdr l) pointer tuple))))
  (car (iter (car l) (cdr l) (cdr l) (list ( car l) 0))))

(display "Testing: 2d")(newline)

(display "Testing: max-t")(newline)
(display "(max-t '(a 2) (b 4)'):")(newline)
   (display "Expected: (b 4)")(newline)
   (display "Actual: ")(max-t '(a 2) '(b 4))(newline)

(display "Testing: mode")(newline)
(display "((mode '(a b a c a d d a b c a b)):")(newline)
   (display "Expected:  a")(newline)
   (display "Actual: ")(mode '(a b a c a d d a b c a b))(newline)

(display "(mode '(2 b a 3 2 c b 1 b 2 d a)):")(newline)
   (display "Expected: 2")(newline)
   (display "Actual: ")(mode '(2 b a 3 2 c b 1 b 2 d a))(newline)

(display "(mode '(1 1 1 1 b b b b )):")(newline)
   (display "Expected:  1")(newline)
   (display "Actual: ")(mode '(1 1 1 1 b b b b ))(newline)

;5
;Purpose: For logging values in decreasing function
(define (info option main-l l  pointer)
  (display "option ") (display option) (display "->")
  (display " main-l: ") (display main-l)(display "\t")
  (display " l: ") (display l) (display "\t")
  (display " pointer: ") (display pointer) (display "\n"))

;Purpose: Return all decreasing sequences in a list
(define (decreasing main-t)
    (define (decrease prev main-l l  pointer)
     (cond ((null? main-l ) (begin (info 1 main-l l  pointer)
                                   (if (null? pointer)
                                       l
                                       ( cons l (decrease  (car pointer) (cdr pointer) '() (cdr pointer)) ))))
           ((> prev (car main-l)) (begin (info 2 main-l l  pointer)
                                         (if (null? l)
                                             (decrease (car main-l) (cdr main-l)  (cons prev (cons (car main-l) '())) pointer)
                                             (decrease (car main-l) (cdr main-l) (append l (cons (car main-l) '())) pointer))))
           (else   (info 3  main-l l  pointer)
                   (if(not (null? l))
                       (cons l (decrease (car pointer) (cdr pointer) '() (cdr pointer)) )
                       (decrease  (car pointer) (cdr pointer) '() (cdr pointer) )))))
  (decrease (car main-t) (cdr main-t)'() (cdr main-t) ))

(display "Testing: 2e")(newline)

(display "Testing: decreasing")(newline)
(display "(decreasing '(1 2 3 3 3 4 5)):")(newline)
   (display "Expected:  ()")(newline)
   (display "Actual: ")(decreasing '(1 2 3 3 3 4 5))(newline)

(display "(decreasing '(3 6 8 9 7 4 8 6 3)):")(newline)
   (display "Expected: ((9 7 4) (7 4) (8 6 3) (6 3))")(newline)
   (display "Actual: ")(decreasing '(3 6 8 9 7 4 8 6 3))(newline)

(display "(decreasing '(7 6 5 4 8 5 2 5 1 5 2 1)):")(newline)
   (display "Expected: ((7 6 5 4) (6 5 4) (5 4) (8 5 2) (5 2) (5 1) (5 2 1) (2 1))")(newline)
   (display "Actual: ")(decreasing '(7 6 5 4 8 5 2 5 1 5 2 1))(newline)
