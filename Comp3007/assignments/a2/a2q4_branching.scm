;Tomi Jaga, 101121458

;The purpose of this function is to recursively solve the eqn in q4
;@params n = the sequence position
;test (f 1) => 1
;test (f 2) => 2
;test (f 3) => 8
;test (f 4) => 29
;test (f 5) => 105

(define (f n)
 (if (< n 3)
     n
     (+
      (* 3 (f (- n 1)))
      (* 2 (f (- n 2)))
      (f (- n 3))
      )
     )
  )


;(f 5)
;(+ (* 3 (f (- 5 1))) (* 2 (f (- 5 2))) (f (- 5 3)))
;(+ (* 3 (f 4)) (* 2 (f 3)) (f 2))
;(+ (* 3 (f 4)) (* 2 (f 3)) (f 2))
;(+ (* 3 (+ (* 3 (f (- 4 1))) (* 2 (f (- 4 2))) (f (- 4 3)))) (* 2 (f 3)) (f 2))
;(+ (* 3 (+ (* 3 (f 3)) (* 2 (f 2)) (f 1))) (* 2 (f 3)) (f 2))
;(+ (* 3 (+ (* 3 (f 3)) (* 2 2) 1)) (* 2 (f 3)) (f 2))
;(+ (* 3 (+ (* 3 (+ (* 3 (f (- 3 1))) (* 2 (f (- 3 2))) (f (- 3 3)))) (* 2 2) 1)) (* 2 (f 3)) (f 2))
;(+ (* 3 (+ (* 3 (+ (* 3 (f 2)) (* 2 (f 1)) (f 0))) (* 2 2) 1)) (* 2 (f 3)) (f 2))
;(+ (* 3 (+ (* 3 (+ (* 3 2) (* 2 1) 0)) (* 2 2) 1)) (* 2 (f 3)) (f 2))
;(+ (* 3 (+ (* 3 (+ 6 2 0)) 4 1)) (* 2 (f 3)) (f 2))
;(+ (* 3 (+ (* 3 8) 4 1)) (* 2 (f 3)) (f 2))
;(+ (* 3 (+ 24 4 1)) (* 2 (f 3)) (f 2))
;(+ (* 3 29) (* 2 (f 3)) (f 2))
;(+ 87 (* 2 (f 3)) (f 2))
;(+ 87 (* 2 (+ (* 3 (f (- 3 1))) (* 2 (f (- 3 2))) (f (- 3 3)))) (f 2))
;(+ 87 (* 2 (+ (* 3 (f 2)) (* 2 (f 1)) (f 0))) (f 2))
;(+ 87 (* 2 (+ (* 3 2) (* 2 1) 0)) (f 2))
;(+ 87 (* 2 (+ 6 2 0)) (f 2))
;(+ 87 (* 2 8) (f 2))
;(+ 87 16 (f 2))
;(+ 87 16 2)
;105



;The purpose of this function is to iteratively solve the eqn in q4
;@params limit = the sequence position
;test (f-it 1) => 1
;test (f-it 2) => 2
;test (f-it 3) => 8
;test (f-it 4) => 29
;test (f-it 5) => 105
(define (f-it limit)
 (define (iter count n1 n2 n3)
   (if(>= count limit)
      n3
      (iter (+ count 1) n2 n3
            (+ (* 3 n3)(* 2 n2) n1))))
  
  (if (< limit 3)
      limit
      (iter 2 0 1 2))
  
  )

;(f-it 5)
;(iter count n1 n2 n3)
;(if (< limit 3) limit (iter 2 0 1 2))
;(if (< 5 3) 5 (iter 2 0 1 2))
;(if #f 5 (iter 2 0 1 2))
;(iter 2 0 1 2)

;(if(>= count limit) n3 (iter (+ count 1) n2 n3 (+ (* 3 n3)(* 2 n2) n1)))
;(if(>= 2 5) 2 (iter (+ 2 1) 1 2 (+ (* 3 2)(* 2 2) 1)))
;(if #f 2 (iter (+ 2 1) 1 2 (+ (* 3 2)(* 2 2) 0)))
;(iter (+ 2 1) 1 2 (+ (* 3 2)(* 2 1) 0))
;(iter (+ 2 1) 1 2 (+ 6 2 0))
;(iter 3 1 2 8)

;(if(>= count limit) n3 (iter (+ count 1) n2 n3 (+ (* 3 n3)(* 2 n2) n1)))
;(if(>= 3 5) 8 (iter (+ 3 1) 2 8 (+ (* 3 8)(* 2 2) 1)))
;(if #f 8 (iter (+ 3 1) 2 8 (+ (* 3 8)(* 2 2) 1)))
;(iter (+ 3 1) 2 8 (+ (* 3 8) (* 2 2) 1))
;(iter 4 2 8 (+ 24 4 1))
;(iter 4 2 8 29)

;(if(>= count limit) n3 (iter (+ count 1) n2 n3 (+ (* 3 n3)(* 2 n2) n1)))
;(if(>= 4 5) 29 (iter (+ 4 1) 8 29 (+ (* 3 29)(* 2 8) 2)))
;(if #f 29 (iter (+ 4 1) 8 29 (+ (* 3 29)(* 2 8) 2)))
;(iter (+ 4 1) 8 29 (+ (* 3 29)(* 2 8) 2))
;(iter 5 8 29 (+ 87 16 2))
;(iter 5 8 29 105)

;(if(>= count limit) n3 (iter (+ count 1) n2 n3 (+ (* 3 n3)(* 2 n2) n1)))
;(if(>= 5 5) 105 (iter (+ 5 1) 29 105 (+ (* 3 105)(* 2 29) 8)))
;(if #t 105 (iter (+ 5 1) 29 105 (+ (* 3 105)(* 2 29) 8)))
;105


































