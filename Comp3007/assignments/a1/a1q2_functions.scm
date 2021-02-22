;Tomi Jaga, 101121458

;The purpose of this function is to get the cube of a value
;@params x = the number to get the cube value
(define (cube x)(* x x x ))

;The purpose of this function is to solve eqn 3x^2 + 1
;@params x = the number to solve eqn on
;test (f 1) => 4
(define (f x) (+ (* 3 (expt x 2) ) 1) )

;The purpose of this function is to solve eqn f(2x) - 2x^3
;@params x = the number to solve eqn on
;test (g 6) => 1
(define (g x) (- (f (* 2 x)) (* 2 (expt x 3)) ))

;The purpose of this function is to solve eqn 3f(x/2) + g(x)
;@params x = the number to solve eqn on
;test (h (* 2 3)) => 85
(define (h x) (+ (* 3 (f (/ x 2))) (g x)))



;Applicative order
;(h (* 2 3))
;(h 6)
;(+ (* 3 (f (/ 6 2))) (g 6))
;(+ (* 3 (f 3)) (g 6))
;(+ (* 3 (+ (* 3 (expt 3 2) ) 1) ) (- (f (* 2 6)) (* 2 (expt 6 3)) ))
;(+ (* 3 (+ (* 3 9) ) 1)  (- (f (* 2 6)) (* 2 216) ))
;(+ (* 3 (+ 27  1) ) (- (f (* 2 6)) 432 ))
;(+ (* 3 28 ) (- (f 12) 432 ))
;(+ (* 3 28 ) (-  (+ (* 3 (expt x 2) ) 1) 432 ))
;(+ 84 (- (+ (* 3 144 ) 1) 432 ))
;(+ 84 (- (+ 432 1) 432 ))
;(+ 84 (- 433 432 ))
;(+ 84 1)
;85

;Normal
;(* 2 3)
;(+ (* 3 (f (/ (* 2 3) 2))) (g (* 2 3)))
;(+ (* 3 (+ (* 3 (expt (/ (* 2 3) 2) 2) ) 1)) (- (f (* 2 (* 2 3))) (* 2 (expt (* 2 3) 3)) ))
;(+ (* 3 (+ (* 3 (expt (/ 6 2) 2) ) 1)) (- (f (* 2 (* 2 3))) (* 2 (expt (* 2 3) 3)) ))
;(+ (* 3 (+ (* 3 (expt 3 2) ) 1)) (- (f (* 2 (* 2 3))) (* 2 (expt (* 2 3) 3)) ))
;(+ (* 3 (+ (* 3 9 ) 1)) (- (f (* 2 (* 2 3))) (* 2 (expt (* 2 3) 3)) ))
;(+ (* 3 (+ 27 1)) (- (f (* 2 (* 2 3))) (* 2 (expt (* 2 3) 3)) ))
;(+ (* 3 28) (- (f (* 2 (* 2 3))) (* 2 (expt (* 2 3) 3)) ))
;(+ 84 (- (f (* 2 (* 2 3))) (* 2 (expt (* 2 3) 3)) ))
;(+ 84 (- (+ (* 3 (expt (* 2 (* 2 3)) 2) ) 1)  (* 2 (expt (* 2 3) 3)) ))
;(+ 84 (- (+ (* 3 (expt (* 2 6) 2) ) 1)  (* 2 (expt (* 2 3) 3)) ))
;(+ 84 (- (+ (* 3 (expt 12 2) ) 1)  (* 2 (expt (* 2 3) 3)) ))
;(+ 84 (- (+ (* 3 144 ) 1)  (* 2 (expt (* 2 3) 3)) ))
;(+ 84 (- (+ 432 1)  (* 2 (expt (* 2 3) 3)) ))
;(+ 84 (- 433  (* 2 (expt (* 2 3) 3)) ))
;(+ 84 (- 433  (* 2 (expt 6 3)) ))
;(+ 84 (- 433  (* 2 216) ))
;(+ 84 (- 433  432 ))
;(+ 84 1)
;(+ 85)

