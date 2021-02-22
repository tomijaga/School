;Tomi Jaga, 101121458

;The purpose of this function is to round the number (z) to the given number of decimal places (n)
;@params z = The number to round
;@params n = the number of decimal places to round to
;test (standard-roundf 1.2224 3) => 1.222
(define (standard-roundf z n)
        (/ (round (* z (expt 10 n))) (expt 10 n) )
)

;The purpose of this function is to solve a quadratic equation
;@params a = cofficient of x^2
;@params b = cofficient of x
;@params c = the single num 
;test (quadratic 1 4 4) => -2

(define (quadratic a b c)
        (if (= a 0) 
            #f
            (if (< (- (expt b 2)  (* 4 a c)) 0)
                #f
                (standard-roundf (/ (+ (- 0 b )(sqrt (- (expt b 2)  (* 4 a c))))
                                    (* 2 a))
                                  3
                )
                ))

)

;The purpose of this function is to make convertion between B, KB and KiB
;@params val = measurement to convert
;@params from = init type
;@params to = Type to convert measuement to
;test (convert 42 "KB" "B") => 42000
;test (convert 42 "B" "KiB") => 0.041
;test (convert 42 "KiB" "KB") => 43.008
;test ((convert 42 "KiBapples" "Bytes") => "Could not convert from KiBapples to Bytes Bytes"

(define (convert val from to)
        (cond ( (and (string=? from "B") (string=? to "KB"))(begin (display "B -> KB :") (standard-roundf (/ val 1000) 3)))
              ((and (string=? from "B") (string=? to "KiB")) (begin (display "B -> KiB :")(standard-roundf (/ val 1024) 3)))
              ((and (string=? from "KB") (string=? to "B")) (begin (display "KB -> B :")(standard-roundf (* val 1000) 3)))
              ((and (string=? from "KB") (string=? to "KiB")) (begin (display "KB -> KiB :")(standard-roundf (/ val 1.024) 3)))
              ((and (string=? from "KiB") (string=? to "KB")) (begin (display "KiB -> KB :")(standard-roundf (* val 1.024) 3)))
              ((and (string=? from "KiB") (string=? to "B")) (begin (display "KiB -> B :")(standard-roundf (* val 1.024) 3)))
              (else (string-append "Could not convert from " from " to " to " Bytes"))
        )
        
)