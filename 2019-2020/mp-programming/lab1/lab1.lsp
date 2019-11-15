;; Лабораторна №1 з предмету "Мультипарадигменне програмування"
;; Виконав: Амброс В. В., студент 3 курсу, гр. ІП-71
;; Варіант №1
;; GNU CLISP 2.49.93+ (2018-02-18)

;; task1
;; concat 3 heads into one list
(print
  (
    (lambda
      (a b c)
      (list (car a) (car b) (car c))
    )
    '(Y U I) '(G1 G2 G3) '(KK LL MM JJJ)
  )
)

;; output: (Y G1 KK)

;; --------------------------------------------------
;; task2
;; concat 3rd, 2nd and 2nd elements into one list
(defun task2 (a b c)
  (list
    (nth 2 a)
    (nth 1 b)
    (nth 1 c)
  )
)

(print (task2 '(Y U I) '(G1 G2 G3) '(KK LL MM JJJ)))
;; output: (I G2 LL)

;; --------------------------------------------------
;; task3
(defun task3 (a b)
  (cond
    ((integerp (car a))
      b
    )
    (t
      (cons (car a) (cdr b))
    )
  )
)

(print (task3 '(1.0 2 3) '(4 5 6)))
;; output: (1.0 5 6)
