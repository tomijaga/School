;Tomi Jaga, 101121458

;The purpose of this function is to get the exponent of a number
;greater than 1
;@params n = The number to find exponent from
;@params exp = The initial exponent (should be 0)
(define (SF_Expt_if_greater_than_1 n exp) 
        (if (< (/ n 10) 1) exp 
                           (SF_Expt_if_greater_than_1 (/ n 10) (+ exp 1)) )   
)

;The purpose of this function is to get the exponent of a number
;less than 1 but greater than 0
;@params n = The number to find exponent from
;@params exp = The initial exponent (should be -1)
(define (SF_Expt_if_less_than_1 n exp) 
        (if (and (> (* n 10) 1) (> n 0)) exp 
                           (SF_Expt_if_less_than_1 (* n 10) (- exp 1)) )   
)

;The purpose of this function is to get the exponent of a number
;@params n = The number to find exponent from
;test (sci-exponent 1.234) => 0
;test (sci-exponent 12345) => 4
;test (sci-exponent 0.001234) => -3
;test (sci-exponent -12345) => 4
(define (sci-exponent n) 
        (if(> n 0) 
          (cond ((>= n 1) (SF_Expt_if_greater_than_1 n 0) )
                (else (SF_Expt_if_less_than_1 n -1)))
          (cond ((>= (* n -1) 1)(SF_Expt_if_greater_than_1 (* n -1) 0))
                (else (SF_Expt_if_less_than_1 (* n -1)  -1) ))
        )        
)

;The purpose of this function is to get the coefficient of the Significant Figure
;@params n = The number to find significant figure coeficient
;test (sci-coefficient 1.234) => 1.234
;test (sci-coefficient 12345) => 1.2345
;test (sci-coefficient 0.001234) => 1.234
(define (sci-coefficient n)
        (/ n (expt 10 (sci-exponent n)))
)

;The purpose of this function is to get the Significant Figure
;@params n = The number to find significant figure from
;test (sci-num 1234567) => "1.234567x10^6"
;test (sci-num 1.234) =>"1.234x10^0"
;test (sci-num 0.001234) => "1.234x10^-3"
;test (sci-num "hello") => #f
(define (sci-num n)
        (if (number? n) 
              (string-append (number->string (sci-coefficient n)) "x10^" (number->string (sci-exponent n)))
              #f
        )
)
