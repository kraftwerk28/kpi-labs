;; usage
;; exit, q - exit cli
;; set - set key
;; get - get key
;; del - delete key
;; print - print tabled database
;; load - load database from file
;; save - save database to file

(load "./db.lsp")

(defun prompt (&optional (str ""))
  (format t "~a > " str)
  (read)
)

(defun exec-cmd (cmd &optional (db (db-init)))
  (cond
    ((member cmd '(exit q))
      (format t "see you soon...")
    )
    ((eq cmd 'save)
      (db-save "db.txt" db)
      (exec-cmd (prompt) db)
    )
    ((eq cmd 'load)
      (let ((t-db (db-load "db.txt")))
        (exec-cmd (prompt) t-db)
      )
    )
    ((eq cmd 'set)
      (let
        ((t-db (db-set db (prompt "key") (prompt "value"))))
        (exec-cmd (prompt) t-db)
      )
    )
    ((eq cmd 'get)
      (let ()
        (print (db-get db (prompt "key")))
        (terpri)
        (exec-cmd (prompt) db)
      )
    )
    ((eq cmd 'del)
      (let
        ((t-db (db-del db (prompt "key"))))
        (exec-cmd (prompt) t-db)
      )
    )
    ((eq cmd 'print)
      (db-print db)
      (terpri)
      (exec-cmd (prompt) db)
    )
    ((eq cmd 'sort)
      (exec-cmd (prompt) (db-sort db))
    )
    (t
      (format t "there is nothing to do")
      (terpri)
      (exec-cmd (prompt) db)
    )
  )
)

(exec-cmd (prompt))
