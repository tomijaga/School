;Tomi Jaga, 101121458

;This is a higher order function that returns the result of a product sequence using a recursive process
;@params i = the initial sequence position
;@params end = the last position of the sequence
;@params term = the calculation for al the sequence terms
;@params next = function to calculate the next position in the sequence
;test (product 0 5 (lambda (x)x) (lambda(x)(+ x 1))) => 0
;test (product 1 1  (lambda (x)x) (lambda(x)(+ x 1))) => 1
;test (product 1 5 (lambda (x)x) (lambda(x)(+ x 1))) => 120
(define (product i end term next)
  (if (> i end)
      1
      (* (term i)
         (product (next i) end term next))))


;This is a higher order function that returns the result of a product sequence using an iterative process
;@params i = the initial sequence position
;@params end = the last position of the sequence
;@params term = the calculation for al the sequence terms
;@params next = function to calculate the next position in the sequence
;test (product-it 0 5 (lambda (x)x) (lambda(x)(+ x 1))) => 0
;test (product-it 1 1  (lambda (x)x) (lambda(x)(+ x 1))) => 1
;test (product-it 1 5 (lambda (x)x) (lambda(x)(+ x 1))) => 120
(define (product-it i end term next)
  (define (iter i value)
  (if (> i end)
      value
      (iter (next i) (* value (term i)))))
  (iter i 1))

;The purpose of this function is to get a squared value
;@params num = the number to square
;test (square 2) => 4
;test (square 5) => 24
(define (square x) (* x x))


;The purpose of this function is to get a cubed value
;@params num = the number to get the cube value
;test (cube 5) => 125
;test (cube 2) => 8
(define (cube x) (* x x x))

;A function that adds 1 to the number passed in
;@params x = a number
;test (add1 5) => 6
;test (add1 2) => 3
(define (add1 x) (+ x 1))


;A function that solves 2ci
;@params init = start of sequence
;@params end = end of sequence
;test (PI-1 2 2) => 4
;test (PI-1 2 3) => 72

;solution to 2ci
;(PI-1 2 20) => 720018831126277480427380151560144480842547200000000000
(define (PI-1 init end)
  (product-it init end (lambda (x)
                         (- (cube x) (square x)))
              add1))


;A function that solves 2cii
;@params init = start of sequence
;@params end = end of sequence
;test (PI-2 1 1) => 9
;test (PI-2 1 2) => 225

;solution to 2cii
;(PI-2 2 15) => 36825143286290325050565453237890625

(define (PI-2 init end)
  (product-it init end (lambda (x)
                         (square (+ (* 2 x) 1)))
              add1))

;A function that solves 2ciii
;@params a-end = end of 1st sequence
;@params b-end = end of 2nd sequence
;test (PI-3 1 1) => 2
;test (PI-3 1 2) => 12

;solution to 2ciii
;(PI-3 5 6) => 15116544000
(define (PI-3 a-end b-end)
  (* (product-it 1 a-end (lambda (x)
                         (* 3 x))
                          add1)
     (product-it 1 b-end square  add1  )))
