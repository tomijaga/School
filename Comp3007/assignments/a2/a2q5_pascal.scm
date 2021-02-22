;Tomi Jaga, 101121458

;The purpose of this function is to get the pascal value at a specific row and col
;@params r = row to lookup
;@params c = col to lookup
;test (pascals 0 0) => 1
;test (pascals 0 1) => 0
;test (pascals 0 2) => 0
;test (pascals 4 2) => 6
;test (pascals 3 3) => 1
;test (pascals 6 4) => 15
(define (pascals r c)
  (define (pascal row col)
        (if (and (>= row 0) (or (= col 0) (= col row)))
            1
            (+ (pascal (- row 1) col) (pascal (- row 1) (- col 1)))))
  (if ( and (<= c r) (>= c 0) (>= r 0))
      (pascal r c)
      0))


;The purpose of this function is to print a specific row in the pascals triangle
;@params row = row to print
;test (printRow -1) => 
;test (printRow 0) => 1
;test (printRow 1) => 1 1
;test (printRow 2) => 1 2 1
;test (printRow 3) => 1 3 3 1 
;test (printRow 4) => 1 4 6 4 1 
;test (printRow 5) => 1 5 10 10 5 1
(define (printRow row)
  (define (iter col)
    (if (> col row)
        (display "\n")
        (begin (display (pascals row col)) (display " ") (iter (+ col 1)))))
  (iter 0))

;The purpose of this function is to print a pascal triangle till the limit is reached
;@params row = row to print
;test (printtriangle -1) => 
;test (printtriangle 6) => 1
;                          1 1
;                          1 2 1
;                          1 3 3 1 
;                          1 4 6 4 1 
;                          1 5 10 10 5 1
(define (printTriangle row)
  (define (iter i)
    (if (< i row)
        (begin (printRow i) (iter (+ i 1)))))
  (iter 0))