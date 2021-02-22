;Tomi Jaga, 101121458

;The purpose of this function is to compare two characters to determine if they are equal or not
;@params s = a string to get characters from
;@params i = the position of the first character
;@params b = the position of the second character
;test (cmpchar "carat" 0 4) => #f
;test (cmpchar "carat" 1 3) => #t
;test (cmpchar "carat" 2 2) => #t
(define (cmpchar s i n)
      (equal?(string-ref s i)
         (string-ref s n)))

;The purpose of to determine if a word is a palindrome while up to k characters
;@params s = string to check if it is a palindrome
;@params k = the number of characters to ignore
;test (k-palindrome? "carat" 0) => #f
;test (k-palindrome? "carat" 1) => #t
;test (k-palindrome? "tacocat" 1) => #t
;test (k-palindrome? "taco cat" 0) => #f
;test (k-palindrome? "taco cat" 1) => #t
;test (k-palindrome? "tahcohcat" 0) => #f
;test (k-palindrome? "tahcohcat" 1) => #f
;test (k-palindrome? "tahcohcat" 2) => #t
(define (k-palindrome? s k)
  (define (iter i n s times-ignored)
    
    (define (next-iter times-ignored)
     (iter (+ i 1) (- n 1) s times-ignored))
    
    (cond ((>= i n) #t)
         ((cmpchar s i n) (next-iter times-ignored) )
         ((< times-ignored k) (next-iter (+ times-ignored 1)))
         (else #f)
       ))
  (iter 0 (- (string-length s) 1) s 0))

;The purpose of to determine if a word is a real palindrome
;@params s = string to check if it is a palindrome
;test (k-palindrome? "carat") => #f
;test (k-palindrome? "tacocat") => #t
;test (k-palindrome? "taco cat" 0) => #f
;test (k-palindrome? "tahcohcat" ) => #f
(define (palindrome? s)
  (k-palindrome? s 0))