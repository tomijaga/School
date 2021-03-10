;1
(define (tree-reduce operator initial t)
  (cond ((null? t) initial)
        ((list? (car t)) (operator (tree-reduce operator initial (car t))
                                   (tree-reduce operator initial (cdr t))))
        (else (operator (car t)
                        (tree-reduce operator initial (cdr t))))))


;2
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

;3
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

;4
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

(tree-merge list-1 list-2)