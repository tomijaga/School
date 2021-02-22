;Tomi Jaga, 101121458

;The purpose of this function is to approximate a cube root value
;@params x = the number to get the cube root
;test (cbrt -27) => -3
;test (cbrt 1) => 1
;test (cbrt 8) => 2
;test (cbrt 27) => 3
;test (cbrt 125) => 5
(define (cbrt x) 

        ;The purpose of this function is to get a squared value
        ;@params num = the number to square
        ;test (square 2) => 4
        ;test (square 5) => 25
        (define (square num)(* num num))

        ;The purpose of this function is to get a cubed value
        ;@params num = the number to get the cube value
        ;test (cube 5) => 125
        ;test (cube 2) => 8
        (define (cube num)(* num num num))

        ;The purpose of this function is to check if the approximation is good enough
        ;@params guess = the approximated guess for the cube root
        ;@params x = the value to find the cube root from
        (define (goodEnough? guess x) 
                (< (abs (- (cube guess) x)) 0.00001))

        ;The purpose of this function is to round the a value to a give number of decimal places
        ;@params z = the number to round
        ;@params x = the number of decimal places to round to
        (define (round-to-n z n)
        (/ (round (* z (expt 10 n))) (expt 10 n) ))

        ;The purpose of this function is to get an approximation closer to the cube root
        ;@params guess = the previous approximation
        ;@params x = the value to find the cube root from
        (define (improve guess x)
                (/ (+ (/ x (square guess)) (* 2 guess)) 3))

        ;This functions iterates to get a better approximation and round the value till the value is good enough to return
        ;@params guess = the current approximation
        ;@params x = the value to find the cube root from
        (define (cbrt-iter guess x)
                (if (goodEnough? guess x) 
                    (round-to-n guess 3)
                    (cbrt-iter (improve guess x) x)))

        (cbrt-iter 1 x)    
)

;b) No the new version does not work. 
; the function takes too long because 
(define (cbrt x) 
        (define (new-if predicate consequent alternate)
        (cond (predicate consequent)
            (else alternate)))

        (define (square num)(* num num))

        (define (cube num)(* num num num))

        (define (goodEnough? guess x) 
                (< (abs (- (cube guess) x)) 0.00001))

        (define (round-to-n z n)
        (/ (round (* z (expt 10 n))) (expt 10 n) ))

        (define (improve guess x)
                (/ (+ (/ x (square guess)) (* 2 guess)) 3))

         (define (cbrt-iter guess x)
                (new-if (goodEnough? guess x) 
                    (round-to-n guess 3)
                    (cbrt-iter (improve guess x) x)))

        (cbrt-iter 1 x)    
)