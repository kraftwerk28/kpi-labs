;; initialize empty database
(defun db-init () '())

(defun db-size (db)
  (tuple-len db)
)

(defun db-print (db &optional (do-head t))
  (terpri)
  (if do-head
    (let ()
      (format t "key~a|~avalue" #\tab #\tab)
      (terpri)
    )
  )
  (if (not (null db))
    (let ()
      (format t "~a~a|~a~a" (caar db) #\tab #\tab (cadar db))
      (db-print (cdr db) nil)
    )
  )
)

(defun db-clear ()
  NIL
)

(defun db-set (db key val) 
  (tuple-set db key val)
)

(defun db-get (db key) 
  (tuple-get db key)
)

(defun db-has (db key) 
  (tuple-has db key)
)

(defun db-del (db key) 
  (tuple-del db key)
)

;; tuple (dict) primitive operations
(defun tuple-len (tup)
  (if (null tup)
    0
    (length tup)
  )
)

(defun tuple-verify (tup)
  (if (and (listp (car tup)) (eq (length tup) 2))
    tup
    (error "Storage injured!")
  )
)

(defun tuple-get (tup key)
  (cond
    ((null tup) nil)
    ((equal (caar tup) key) (cadar tup))
    (t (tuple-get (cdr tup) key))
  )
)

(defun tuple-set (tup key val)
  (cons (list key val) tup)
)

(defun tuple-del (tup key)
  (cond
    ((null tup) nil)
    ((equal (caar tup) key) (cdr tup))
    (t (cons
      (car tup)
      (tuple-del (cdr tup) key)
    ))
  )
)

(defun tuple-has (tup key)
  (cond
    ((null tup) nil)
    ((equal (caar tup) key) t)
    (t (tuple-has (cdr tup) key))
  )
)


;; load/save

(defun db-save(path db)
  (with-open-file 
    (
      out path :direction :output
      :if-exists :supersede :if-does-not-exist :create
    )
    (with-standard-io-syntax (print db out))
    (format out "~%")
  )
  db
)

(defun db-load(path)
  (with-open-file (in path)
    (with-standard-io-syntax (read in))
  )
)
