### A Turing machine based subtractor implemented in Sendmail

In September 1998 I wrote a [Turing machine](https://en.wikipedia.org/wiki/Turing_machine)
simulator in [Sendmail](https://en.wikipedia.org/wiki/Sendmail).
More info is archived in [comp.mail.sendmail](http://bit.ly/sendmail-turing).
Unfortunately, setting up Sendmail is hard work for some, so now you can experiment with the
code encapsulated in Docker. To run it do:

    docker run --net=none -i -t pvanheus/sendmail-turing:latest

You'll get a prompt like:


    local mailer defined
    ADDRESS TEST MODE (ruleset 3 NOT automatically invoked)
    Enter <ruleset> <address>
    >
Enter a sum with something like `tStart 1 1 0 1` (to do 2 - 1) and it will compute and show
you the answer.

The `1 1 0 1` is a *tape* containing two numbers (2 and 1) in unary notation. The Sendmail
email address rewriting language is (ab)used to create a simple automaton that
moves back and forward on the tape, removing a `1` from the first number
for each `1` that exists in the second number (this only works if the first
number is greater than the second). Some limitations are explained in the
original post.

Incidentially this subtraction with unary notation is somewhat similar
to operations using Peano axioms. For a Scala introduction to Peano numbers
see [here](https://apocalisp.wordpress.com/2010/06/16/type-level-programming-in-scala-part-4a-peano-number-basics/) and
the succeeding posts [here](https://apocalisp.wordpress.com/2010/06/17/type-level-programming-in-scala-part-4b-comparing-peano-numbers/),
[here](https://apocalisp.wordpress.com/2010/06/21/type-level-programming-in-scala-part-4c-general-recursion-on-peano-numbers/) and
finally [here](https://apocalisp.wordpress.com/2010/06/21/type-level-programming-in-scala-part-4d-peano-arithmetic/).

And in case you want to use this with [Singularity](http://singularity.lbl.gov/), here is a [Singularity image](https://drive.google.com/file/d/0By2-i8xoBou_V0pEbVZlT19vdXc/view?usp=sharing). So you can go:

    singularity run sendmail-turing.img

(and wait a while for it to start, then use as above)
