?- time(run("

    (defun fib (n)
      (setq f (cons 0 1))
      (setq i 0)
      (while (< i n)
        (setq f (cons (cdr f) (+ (car f) (cdr f))))
        (setq i (+ i 1)))
      (car f))

    (fib 350)

    ", V)).
