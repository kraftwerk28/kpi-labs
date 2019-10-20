(load "./db.lsp")

(defun exec-cmd (db cmd)
  (cond
    ((eq cmd 'exit) (print 'bye) t)
    (t (format t "there is nothing to do"))
  )
)

(loop
  (terpri)
  (format t "> ")
  (setq do-exit (exec-cmd nil (read)))
  (when do-exit (return 0))
)
