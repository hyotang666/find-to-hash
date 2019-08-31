# find-to-hash
## What is this?
Converter which accepts CL:FIND form, then generate equivalent GETHASH form.

### Current lisp world
Efficiency is important.
But many lisper does not care about using CL:FIND.

e.g.

```lisp
(defun upper-hex-char-p(char)
  (find char "1234567890ABCDEF"))
```

### Issues
CL:GETHASH faster than linear search that CL:FIND do.
But naive implementation is so tough.

e.g.

```Lisp
(let((ht(make-hash-table)))
  (map nil
       (lambda(char)
         (setf (gethash char ht) char))
       "1234567890ABCDEF")
  (defun upper-hex-char-p(char)
    (values (gethash char ht))))
```

It is hard to implement, and hard to read.

### Proposal
FIND-TO-HASH provides named readtables.
You can write like this.

```lisp
(named-readtables:in-readtable find-to-hash:syntax)

(defun upper-hex-char-p(char)
  #H(find char "1234567890ABCDEF"))
```

## From developer

### Product's goal

### License
Public domain.

### Developed with
SBCL

### Tested with
SBCL/1.5.5

## Installation
TODO
