(defun rev (l)
  (cond
    ((null l) '())
    (t (append (rev (cdr l)) (list (car l))))))

(defun task1 (lst)
  (cond
    ((null lst) lst)
    (t (append (rev lst) (task1 (cdr lst))))))
    
;; (print (task1 '(1 2 3 4)))


;; insertion sort
;; (defun task3 (i l &optional (k #'<))
;;   (if (null l)
;;     (list i)
;;     (if (funcall k i (car l))
;;       (cons i l)
;;       (cons (car l) (task3 i (cdr l) k)))))

(defun task3 (lst &optional (key #'<))
  (if (null lst)
    lst
    (task3 (car lst) (task3 (cdr lst) key) key)))

;; (print (task3 '(3 2 4 4 1)))


;; merge lists
(defun task4 (l1 l2 &optional res #'())
  (cond
    ((and (null l1) (null l2))
      res)
    ((null l1)
      (append res l2))
    ((null l2)
      (append res l1))
    ((< (car l1) (car l2))
      (task4 (cdr l1) l2 (append res (list (car l1)))))
    (t
      (task4 l1 (cdr l2) (append res (list (car l2)))))))

;; (print (task4 '(1 4 6 7) '(2 3 5 10)))


;; sub list search
(defun task5 (l lst depth)
  (cond
    ((null (car lst)) nil)
    ((equal (car lst) l) t)
    ((eq 0 depth) nil)
    ((listp (car lst)) (task5 l (car lst) (- depth 1)))))

(print (task5 '(1 2 3) '(12) 4))
