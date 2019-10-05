(defun set-by-index (v i l)
  (cond
    ((eq i 0) (cons v (cdr l)))
    (t (cons (car l) (set-by-index v (- i 1) (cdr l))))))

(defun swap (i j l)
  (cond
    ((> i j) (swap j i l))
    (t (set-by-index (nth i l) j (set-by-index (nth j l) i l)))))

(defun step-even (i)
  (+ 1 (- (* 9 (expt 2 i)) (* 9 (expt 2 (/ i 2))))))

(defun step-odd (i)
  (+ 1 (- (* 8 (expt 2 i)) (* 6 (expt 2 (/ (+ i 1) 2))))))

(defun inc-step (i)
  (cond
    ((eq (mod i 2) 0) (step-even i))
    (t (step-odd i))))

(defun check-step (v s)
  (cond
    ((null v) t)
    ((> (* v 3) s) nil)
    (t t)))

(defun inc-steps (s &optional (i 0) steps)
  (cond
    ((check-step (car steps) s) (inc-steps s (+ i 1) (cons (inc-step i) steps)))
    (t (cdr steps))))

(defun sort-step-until (i step l &optional (j i))
  (cond
    ((< j 0) l)
    ((< (nth i l) (nth j l))
      (sort-step-until j step (swap i j l) (- j step)))
    (t (sort-step-until i step l (- j step)))))

(defun sort-step (step l &optional (i 0))
  (cond
    ((>= i (length l)) l)
    (t (sort-step step (sort-step-until i step l) (+ i step)))))

(defun sort-by-steps (steps l)
  (if
    (null steps)
    l
    (sort-by-steps (cdr steps) (sort-step (car steps) l))))


;;------------------------------------------------------------------------------
(defun shell-sort (l)
  (sort-by-steps (inc-steps (length l)) l))

(print (shell-sort '(10 9 8 7 6 5 4 3 2 1)))
