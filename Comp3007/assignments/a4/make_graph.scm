;Purpose: Higher order fn for traversing list
;@param list - list to traverse
;@param fn - function to call on each list item
(define (traverse list fn)
    (define (iter l)
      (if  (not (null? l))
            (begin (fn (car l)) (iter (cdr l)))))
  (iter list))

;Purpose: Higher order fn for filtering a list
;@param list - list to filter
;@param fn - function to call on each list item
(define (filter graph fn)
  (define (iter graph l)
    (cond ((null? graph) l)
          ((fn (car graph)) (if (list? l)
                                (iter (cdr graph) (append l (list (car graph))))
                                (iter (cdr ligraphst) (append (list l) (car list)))))
          (else (iter (cdr graph) l))))
  (iter graph '()))


;This is a new object in scheme that contains procedures to make a graph
(define (make-graph)
  (define graph '())

  ;Purpose: Creates a new node
  ; @params x = The value of the new node
  (define (new-node x)
  (list x '()))

  ;Purpose: Checks if a node exists
  ;@param x - value of node to check
  (define (node-exists? x)
   
    (define (iter g)
      
      (cond ((null? g) #f)        
            ((eq? (caar g) x) #t)
          (else (iter (cdr g)))))
    (iter graph))

;Purpose: Gets a node from the graph
;@param x - the value of node to get
  (define (get-node x)
    (define (iter graph)
    
      (cond ((null? graph) '())        
            ((eq? (caar graph) x) (car graph))
            (else (iter (cdr graph)))))
    (iter graph))
  
;Purpose: Adds a node to the graph
;@param x  value of node to add
;Returns #t if added and #f if node already exists
  (define (add-node x)
 
    (if (node-exists? x)
        #f
        (begin (set! graph (cons  (new-node x) graph )) #t)))

  ;Must return a value in
  ;Purpose: Update the graph
  ;@param fn - function to specify changes
  (define (update fn)
     (define l '())
     (traverse graph (lambda (n)
                      ; (display l) (newline)
                       (set! l (cons (fn n) l))))
    (set! graph l))

  (define (edge-exists? x y)
    (define result #f)

    (define (exists?-log n)  (display n) (display "==") (display y) (display " edge exists at ") (display x)  (newline) )
    (let ((node-x (get-node x))
          (node-y (get-node y)))
      
     (if (and (not (null? node-x  )) (not(null? node-y )) )
         (begin 
                (traverse (cadr node-x) (lambda (n)  (if (eq? n y)
                                                        (begin  (set! result #t) ;(exists?-log n)
                                                                )
                                                       )))
               result)
          #f)))

;Purpose: Add an edge to the graph
;@param x - the node of the first node
;@param y - the node of the 2nd node
;Returns #t if edge is added and #f is edge already exists
  (define (add-edge x y)
  (define edge-was-added #f)
    (cond ((or (null? (get-node x) ) (null? (get-node y) ) (eq? x y)) #f)
          ((edge-exists? x y) #f)
          (else  (begin (update (lambda (n) (if (eq? (car n) x)
                                                (begin (set! edge-was-added #t) (list (car n) (cons y (cadr n))) )
                                                n))) edge-was-added))))
  
;Purpose: Remove an edge to the graph
;@param x - the node of the first node
;@param y - the node of the 2nd node
  (define (remove-edge x y)

  (define removed-edge #f)

    (cond ((or (null? (get-node x) ) (null? (get-node y) ) (eq? x y)) #f)
          ((edge-exists? x y) (begin (update (lambda (n)
                                        (if (eq? (car n) x)
                                            (begin ;(display n)  (display ":\t")
                                              (list (car n)
                                                    (filter (cadr n) (lambda (e)
                                                                             (begin ;(display e )  (display " " )
                                                                               (not (eq? y e)) ))) ) )
                                            n))) (set! removed-edge #t)) )
          (else #f)
          ) removed-edge)

;Purpose: Remove a node to the graph
;@param x  value of node to remove
  (define (remove-node x)
  (define removed-node #f)
    (traverse graph (lambda (n)
                      (if (not(null? (cadr n)))
                          (remove-edge (car n) x))))
    
    (set! graph (filter graph (lambda (n)
                                      (if (eq? (car n ) x)
                                          (begin (set! removed-node #t) #f)
                                          #t)))) removed-node )

;Purpose: display the current nodes and edges on the graph
  (define (g-display)

    (define (print str) (if (eq? str 'node)
                            (lambda (x) (newline) (display x) (display ": "))
                            (lambda (x) (display x) (display " "))) )
    (display "Displaying graph ...") (newline)                       
    (traverse graph
              (lambda (x)
                ((print 'node) (car x))
                (if (not (null? x))
                    (traverse (cadr x) (print 'edge))
                    
                     )
                ))(newline)(newline))

  (define (dispatch str)
    (cond ((eq? str 'add-node) add-node)
          ((eq? str 'add-edge) add-edge)
          ((eq? str 'remove-edge) remove-edge)
          ((eq? str 'remove-node) remove-node)
          ((eq? str 'display) g-display)
          (else #f)))
  dispatch)

(define G (make-graph))
(display "Testing: 4")(newline)
(display "Testing: add-node")(newline)

(display "((G 'add-node) 1) :")(newline)
   (display "Expected: #t")(newline)
   (display "Actual: ")((G 'add-node) 1) (newline)

(display "((G 'add-node) 1) :")(newline)
   (display "Expected: #f")(newline)
   (display "Actual: ")((G 'add-node) 1) (newline)

(display "((G 'add-node) 2) :")(newline)
   (display "Expected: #t")(newline)
   (display "Actual: ")((G 'add-node) 2) (newline)

(display "((G 'add-node) 'a) :")(newline)
   (display "Expected: #t")(newline)
   (display "Actual: ")((G 'add-node) 'a) (newline)

(display "((G 'add-node) 'b) :")(newline)
   (display "Expected: #t")(newline)
   (display "Actual: ")((G 'add-node) 'b) (newline)

(display "((G 'add-node) 'b) :")(newline)
   (display "Expected: #f")(newline)
   (display "Actual: ")((G 'add-node) 'b) (newline)

((G 'display))


(display "Testing: add-edge")(newline)
(display "((G 'add-edge) 'a 'b) :")(newline)
   (display "Expected: #t")(newline)
   (display "Actual: ")((G 'add-edge) 'a 'b) (newline)

(display "((G 'add-edge) 1 'b) :")(newline)
   (display "Expected: #t")(newline)
   (display "Actual: ")((G 'add-edge) 1 'b) (newline)

(display "((G 'add-edge) 1 5) :")(newline)
   (display "Expected: #f")(newline)
   (display "Actual: ")((G 'add-edge) 1 5) (newline)

(display "((G 'add-edge) 1 'b) :")(newline)
   (display "Expected: #f")(newline)
   (display "Actual: ")((G 'add-edge) 1 'b) (newline)

(display "((G 'add-edge) 1 'a) :")(newline)
   (display "Expected: #t")(newline)
   (display "Actual: ")((G 'add-edge) 1 'a) (newline)

(display "((G 'add-edge) 1 2) :")(newline)
   (display "Expected: #t")(newline)
   (display "Actual: ")((G 'add-edge) 1 2) (newline)

(display "((G 'add-edge) 1 1) :")(newline)
   (display "Expected: #f")(newline)
   (display "Actual: ")((G 'add-edge) 1 1) (newline)

(display "((G 'add-edge) 2 1) :")(newline)
   (display "Expected: #t")(newline)
   (display "Actual: ")((G 'add-edge) 2 1) (newline)

(display "((G 'add-edge) 'b 1) :")(newline)
   (display "Expected: #t")(newline)
   (display "Actual: ")((G 'add-edge) 'b 1) (newline)

((G 'display))

(display "Testing: remove-node")(newline)
(display "((G 'remove-node) 'b) :")(newline)
   (display "Expected: #t")(newline)
   (display "Actual: ")((G 'remove-node) 'b) (newline)

(display "((G 'remove-node) 'z) :")(newline)
   (display "Expected: #f")(newline)
   (display "Actual: ")((G 'remove-node) 'z) (newline)

((G 'display))

(display "Testing: remove-edge")(newline)
(display "((G 'remove-edge) 1 2) :")(newline)
   (display "Expected: #t")(newline)
   (display "Actual: ")((G 'remove-edge) 1 2) (newline)

(display "((G 'remove-edge) 1 5) :")(newline)
   (display "Expected: #f")(newline)
   (display "Actual: ")((G 'remove-edge) 1 5) (newline)

((G 'display))


