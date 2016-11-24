### A Turing machine based subtractor implemented in Sendmail

In September 1998 I wrote a Turing machine simulator in Sendmail. More info
is archived in [comp.mail.sendmail](http://bit.ly/sendmail-turing). Unfortunately,
setting up Sendmail is hard work for some, so now you can experiment with the 
code encapsulated in Docker. To run it do:

    docker run -i -t pvanheus/sendmail-turing:latest

You'll get a prompt like:


    local mailer defined
    ADDRESS TEST MODE (ruleset 3 NOT automatically invoked)
    Enter <ruleset> <address>
    >
Enter a sum with something like `tStart 1 1 0 1` (to do 2 - 1) and it will compute and show
you the answer.

The `1 1 0 1` is a *tape* containing two numbers in unary notation. Read the original post
for more info.
