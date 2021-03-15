#|
Author: Tomi Jaga
Stident Number: 101121458

|#

;a
;
(define square (lambda(x)(* x x)))
(define double (lambda(x)(+ x x)))

;The purpose of this function is create a a composed function
;@params f = The second function to call with the returned value of 
;@params g = The first function to call with the a param x

(define (compose f g) (lambda (x) (f( g x))))

;Testing 
;example
(display "Testing: 1a")(newline)
(display "((compose square double) 3):")(newline)
   (display "Expected: 36")(newline)
   (display "Actual: ")((compose square double) 3)(newline)

(display "((compose square double) 3):")(newline)
   (display "Expected: ( (20 * 2) ^ 2 = 40 ^ 2 = 1600)")(newline)
   (display "Actual: ")((compose square double) 20)(newline)

;2
;The purpose of this procedure is to create a hihger order function checks if a number is divisible by 3
;@params x = the number to divide by
;returns a function
(define (divisibleBy x) (lambda (n) (= (- n (* (floor (/ n x)) x))  0)))

;The purpose of this function is to determine if a number is divisble by 3
;@params n = checking to make sure this number is divisible by 3
;returns a boolean value
(define mod3 (divisibleBy 3) )

;Testing 
(display "Testing: 1b")(newline)
(display "(mod3 7):")(newline)
   (display "Expected: #f")(newline)
   (display "Actual: ")(mod3 7)(newline)

(display "(mod3 9):")(newline)
   (display "Expected: #t")(newline)
   (display "Actual: ")(mod3 9)(newline)

;Testing prime number: 43
(define mod43 (divisibleBy 43))

(display "(mod43 7):")(newline)
   (display "Expected: #f")(newline)
   (display "Actual: ")(mod43 7)(newline)

(display "(mod43 43):")(newline)
   (display "Expected: #t")(newline)
   (display "Actual: ")(mod43 43)(newline)

(display "(mod43 1):")(newline)
   (display "Expected: #f")(newline)
   (display "Actual: ")(mod43 1)(newline)

(display "(mod43 137):")(newline)
   (display "Expected: #f")(newline)
   (display "Actual: ")(mod43 137)(newline)


;3
;The purpose of this function is to add an element in the first position of a list
;@params l = the list
;@params x = The element to add to list
;returns a new list with the element in it
(define (unshift l x) (cons x l))

;Purpose: Retrieve an element at a specific position in a list
;@params items = List of stored elements
;@params i = index of stored item
;returns element if found otherewise it returns nothing
(define (get-element items i)
    (if (= i 0)
        (car items)
        (get-element (cdr items) (- i 1))))

;Purpose: Higher order function to iterate through a list
;@params: Function to apply to the list elements while mapping
;returns new list value
(define (newmap fn)
 
    (define (iter prevList l i)
       (if (< i 0)
        l  
        (iter prevList
              (unshift l (fn (get-element prevList i)))
              (- i 1) )))
  
   (lambda (prevList)
    (iter prevList '() (- (length prevList) 1))))

;Purpose: Multiplies all elements in list by 2
;@params x = list to multiple 
(define double-mapper (newmap (lambda(x)(* x 2))))

(display "Testing: 1c")(newline)
(display "Testing: unshift")(newline)
(display "(unshift '(2 3 4 5) 1):")(newline)
   (display "Expected: (1 2 3 4 5)")(newline)
   (display "Actual: ")(unshift '(2 3 4 5) 1)(newline)

(display "Testing: get-element")(newline)
(display "(get-element '(0 1 2 3 4 5) 3):")(newline)
   (display "Expected: 3")(newline)
   (display "Actual: ")(get-element '(0 1 2 3 4 5) 3)(newline)

(display "Testing: double-mapper")(newline)
(display "(double-mapper '(10 20 30)):")(newline)
   (display "Expected: (20 40 60)")(newline)
   (display "Actual: ")(double-mapper '(10 20 30))(newline)

(display "Testing: double-mapper")(newline)
(display "(double-mapper '(1 2 3 4)):")(newline)
   (display "Expected: (2 4 6 8)")(newline)
   (display "Actual: ")(double-mapper '(1 2 3 4))(newline)


;4
;Purpose: Higher order fn to filter items in a list according to boolean return value;
;@params fn = A function that returns a boolean which determines if the item is returned or removed
(define (newfilter fn)
  (define (filter prevList l i)
 
      (cond ((< i 0)  l)
            (( not (fn (get-element prevList i)))
             (filter prevList (unshift l (get-element prevList i)) (- i 1)))
            (else  (filter prevList l (- i 1)))))
  
  (lambda (prevList) (filter prevList '() ( - (length prevList) 1))))

(display "Testing: 1d")(newline)
(display "Testing: newfilter")(newline)
(display "((newfilter (divisibleBy 2)) '(1 2 3 4 5)):")(newline)
   (display "Expected: (1 3 5)")(newline)
   (display "Actual: ")((newfilter (divisibleBy 2)) '(1 2 3 4 5))(newline)

(display "((newfilter (divisibleBy 10)) '(1 20 3 40 5)):")(newline)
   (display "Expected: (1 3 5)")(newline)
   (display "Actual: ")((newfilter (divisibleBy 2)) '(1 2 3 4 5))(newline)

(display "((newfilter (lanbda(x) #t)) '(1 2 3 4 5)):")(newline)
   (display "Expected: ()")(newline)
   (display "Actual: ")((newfilter (lambda(x) #t)) '(1 2 3 4 5))(newline)


;5
;Purpose: Returns a list from a to b
;@params a; Start of list
;@params b; End of list
(define (range a b)
    (if (= a b) (list a)
        (cons a (range (+ a 1) b))))

(define square (lambda (x) (* x x)))

;Purpose: A function that filters number that are not divisibly by 4
(define filter-not-4 (lambda (filter) (not ((divisibleBy 4) filter))))

;Purpose: A function that returns filters according to a specific formula
(define myfunc (lambda (range)
                ((newmap square)
                 ((newfilter  filter-not-4) range) ))
)

(display "Testing: 1e")(newline)

(display "Testing: filter-not-4")(newline)
(display "(filter-not-4 5):")(newline)
   (display "Expected: #t")(newline)
   (display "Actual: ")(filter-not-4 5)(newline)

(display "Testing: range")(newline)
(display "(myfunc (range 1 5)):")(newline)
   (display "Expected: (1 2 3 4 5)")(newline)
   (display "Actual: ")(range 1 5)(newline)

(display "Testing: myfunc")(newline)
(display "(myfunc (range 1 20)):")(newline)
   (display "Expected: (16 64 144 256 400)")(newline)
   (display "Actual: ")(myfunc (range 1 20))(newline)
