(defpackage :find-to-hash.spec
  (:use :cl :jingoh)
  (:import-from :find-to-hash #:find-to-hash)
  )
(in-package :find-to-hash.spec)
(setup :find-to-hash)

(requirements-about FIND-TO-HASH :doc-type function)

;;;; Description:
; CL:FIND form to equivalent hash-table forms.

#?(find-to-hash(find a "asdf"))
:expanded-to
(values (gethash a (load-time-value
		     (let((find-to-hash::ht
			    (make-hash-table)))
		       (map nil
			    (lambda(elt)
			      (setf (gethash elt find-to-hash::ht)elt))
			    "asdf")
		       find-to-hash::ht)
		     t)))

#+syntax
(FIND-TO-HASH whole) ; => result

;;;; Arguments and Values:

; whole := find-form, otherwise error.
#?(find-to-hash :not-find-form) :signals error

; result := Generalized-boolean. Eval (describe 'cl:find).

;;;; Affected By:
; none

;;;; Side-Effects:
; none

;;;; Notes:
; Only :test keyword parameter is acceptable, otherwise expanded to whole.
#?(find-to-hash (find var '((:a) (:b) (:c)) :key #'car))
:expanded-to (find var '((:a) (:b) (:c)) :key #'car)

; When sequence is not constant, expanded to whole.
#?(find-to-hash (find var not-constant))
:expanded-to (find var not-constant)

;;;; Exceptional-Situations:
; When :test function is not one of EQ, EQL, EQUAL, nor EQUALP,
; behavior is not specified.
#?(find-to-hash (find var '("a" "b" "c") :test #'string=))
=> unspecified
