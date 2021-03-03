(let
    ((a (let
            ((a 1)
              (b 2))
          (* a (+ b a))))
     (b (* 3 (+ 4 2))))
  (+ a (* b a)))

((lambda (a b)
   ((lambda (a b)(+ a (* b a)))
    ((lambda (a) (* a (+ b a))) a)
    (* 3 (+ 4 2))))
 1 2)