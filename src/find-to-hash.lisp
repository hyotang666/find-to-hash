(in-package :cl-user)
(defpackage :find-to-hash
  (:use :cl)
  (:export
    ;;;; main api
    #:find-to-hash

    ;;;; readtable-name
    #:syntax
    ))
(in-package :find-to-hash)

(defmacro find-to-hash(whole)
  (destructuring-bind(op target sequence &rest args)whole
    (assert(eq op 'find))
    (if(constantp sequence)
      whole
      (if(not(typep args '(or null
			      (cons (eql :test)(cons * null)))))
	whole
	(let((hash(gensym"HASH-TABLE")))
	  `(let((,hash
		  (load-time-value
		    (let((ht
			   (make-hash-table
			     ,@(let((test
				      (getf args :test)))
				 (when test
				   `(:test ,test))))))
		      (map nil
			   (lambda(elt)
			     (setf(gethash elt ht)elt))
			   sequence))
		    T))) ; <--- read-only-p
	     (values(gethash ,target ,hash))))))))

(defun |#H-reader|(stream char number)
  (declare(ignore char number))
  (let((form
	 (read stream t t t)))
    (if(atom form)
      form
      (case(car form)
	(find `(find-to-hash ,form))
	(otherwise form)))))

(named-readtables:defreadtable syntax
  (:merge :standard)
  (:dispatch-macro-char #\# #\h '|#H-reader|))
