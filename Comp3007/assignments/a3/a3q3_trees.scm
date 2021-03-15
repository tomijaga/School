;1
;Purpose: Immitates the Array.reduce fn
;@params operator = procedure to call on reduced value
;@params initial = value to start with
;@params t = te tree to reduce

(define (tree-reduce operator initial t)
  (cond ((null? t) initial)
        ((list? (car t)) (operator (tree-reduce operator initial (car t))
                                   (tree-reduce operator initial (cdr t))))
        (else (operator (car t)
                        (tree-reduce operator initial (cdr t))))))
(display "Testing: 3a")(newline)

(display "Testing: tree-reduce")(newline)
(display "(tree-reduce + 0 '(1 (2 3)((4 5) 6 (7)((8 (9)) 10)))):")(newline)
   (display "Expected:  55")(newline)
   (display "Actual: ")(tree-reduce + 0 '(1 (2 3)((4 5) 6 (7)((8 (9)) 10))))(newline)

(display "(tree-reduce * 0 '(1 (2 3)((4 5) 6 (7)((8 (9)) 10)))):")(newline)
   (display "Expected: 0")(newline)
   (display "Actual: ")(tree-reduce * 0 '(1 (2 3)((4 5) 6 (7)((8 (9)) 10))))(newline)

(display "(tree-reduce * 1 '(1 (2 3)((4 5) 6 (7)((8 (9)) 10)))):")(newline)
   (display "Expected: 3628800")(newline)
   (display "Actual: ")(tree-reduce * 1 '(1 (2 3)((4 5) 6 (7)((8 (9)) 10))))(newline)

(display "(tree-reduce / 1 '(1 (2 3)((4 5) 6 (7)((8 (9)) 10)))):")(newline)
   (display "Expected: 15 3/4")(newline)
   (display "Actual: ")(tree-reduce / 1 '(1 (2 3)((4 5) 6 (7)((8 (9)) 10))))(newline)


;2
;Purpose: get the height of a tree
;@params t =  tree to get height from
(define (height t)
  (define (calc-h h t)
    (cond ((null? t) h)
          ((list? (car t)) (max (calc-h (+ h 1) (car t))
                                (calc-h  h (cdr t))))
          (else (+ h
                   (calc-h 0 (cdr t))))))
  (if (list? t)
      (calc-h 1 t)
      0))

(display "Testing: 3b")(newline)

(display "Testing: height")(newline)
(display "(height 'a):")(newline)
   (display "Expected:  0")(newline)
   (display "Actual: ")(height 'a)(newline)

(display "(height '(a)):")(newline)
   (display "Expected: 1")(newline)
   (display "Actual: ")(height '(a))(newline)

(display "(height '(a (b) c)):")(newline)
   (display "Expected: 2")(newline)
   (display "Actual: ")(height '(a (b) c))(newline)

(display "(height '(((((a(((b))))))))):")(newline)
   (display "Expected: 8")(newline)
   (display "Actual: ")(height '(((((a(((b)))))))))(newline)


;3
;Purpose: Flatten all values in a tree into a single lit
;@params main-t = Tree to flatten
(define (flatten-tree main-t)
    (define (flatten t pointer)
      (cond ((null? t) (cond
                         ((null? pointer) pointer)
                         ((list?  pointer) (flatten (cdr pointer) (cdr pointer)))
                         (else pointer)))
            ((list? (car t)) (flatten (car t) pointer)
                              )
            (else (begin  (display pointer)
                          (display "\n")
                          (if (equal? pointer t)
                              (cons (car t) (flatten (cdr pointer) (cdr pointer)))
                              (cons (car t)
                                (flatten (cdr t) pointer))  ))))
                          
     )(flatten main-t main-t ))

(display "Testing: 3c")(newline)

(display "Testing: flatten-tree")(newline)
(display "(flatten-tree '(1 (2 3) ((4 5 6 (7)))(((8 (9)))))):")(newline)
   (display "Expected: (1 2 3 4 5 6 7 8 9)")(newline)
   (display "Actual: ")(flatten-tree '(1 (2 3) ((4 5 6 (7)))(((8 (9))))))(newline)

(display "(flatten-tree '(a (b) c)):")(newline)
   (display "Expected: (a b c)")(newline)
   (display "Actual: ")(flatten-tree '(a (b) c))(newline)

;4
;Purpose: Merge two trees together
;@params T1 = Tree 1 to merge
;@params T2 = Tree 2 to merge

(define (tree-merge T1 T2)
 
    (cond

          ((and (null? T1) (not (null? T2)) (list? T2)) T2)

          ((and (null? T2) (not (null? T1)) (list? T1)) T1)

           ((or (null? T1) (null? T2))  '())

          ((and (not (list? T1)) (not (list? T2))) (* T1 T2))
          
          ((and (list? T1) (list? T2)) (cons (tree-merge  (car T1)  (car T2))
                                             (tree-merge  (cdr T1)  (cdr T2))))
          
          ((and (list? T1) (not (list?  T2))) (cons (tree-merge  (car T1)  T2)
                                                    (tree-merge  (cdr T1)  T2)))

          ((and (list?  T2) (not (list? T1))) (cons (tree-merge T1  (car T2))
                                                    (tree-merge  T1  (cdr T2))))))

(define list-1 '(2 (2 3) (4 5 (5 6 7))))

(define list-2 '((5 (4 3) (2 1)) 6 (7 8)))

(display "Testing: 3c")(newline)

(display "Testing: tree-merge")(newline)
(display "(tree-merge list-1 list-2):")(newline)
   (display "Expected: ((10 (8 6) (4 2)) (12 18) (28 40 (5 6 7)))")(newline)
   (display "Actual: ")(tree-merge list-1 list-2)(newline)

(display "(tree-merge list-1 5):")(newline)
   (display "Expected: (10 (10 15) (20 25 (25 30 35)))")(newline)
   (display "Actual: ")(tree-merge list-1 5)(newline)

(display "(tree-merge list-1 '(10 25 2)):")(newline)
   (display "Expected: (20 (50 75) (8 10 (10 12 14)))")(newline)
   (display "Actual: ")(tree-merge list-1 '(10 25 2))(newline)
