; vim: ft=lisp et
(in-package :asdf)
(defsystem "find-to-hash.test"
  :version
  "0.1.7"
  :depends-on
  (:jingoh "find-to-hash")
  :components
  ((:file "find-to-hash"))
  :perform
  (test-op (o c) (declare (special args))
   (apply #'symbol-call :jingoh :examine :find-to-hash args)))
