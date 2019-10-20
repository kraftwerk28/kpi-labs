;; initialize empty database
(defun db-init () '())


(defun db-set (key val)
  ()
)

(defun db-get (key)
  ()
)

(defun kvstorage-size(kvstorage)
  (length (check-kvstorage-type kvstorage))
)

(defun kvstorage-clear(kvstorage)
  NIL
)

(defun kvstorage-keys(kvstorage)
  (if (not (null (check-kvstorage-type kvstorage)))
    (cons (caar (check-structure kvstorage)) (kvstorage-keys (cdr kvstorage)))
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
