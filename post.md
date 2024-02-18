A copy of the [original post](https://web.archive.org/web/20220525174616/https://groups.google.com/g/comp.mail.sendmail/c/ezncnx9y848/m/cAyV8RLIvfcJ) from comp.mail.sendmail:

I don't know if this has been done before, but just as a challenge (and
for the historical value of it all), I decided to see if I could write
a Turing Machine in sendmail. Well, I did! Below is the code for a
Turing Machine which does substraction. (Of course, it would be better
to write something more flexible - i.e. something which parses some
abstract representation of a state machine and executes it - but that's
left as an exercise for the reader)
The input format for the machine is a tape as follows:

```
X X X X
```

where X is a 1 or 0. The counting system is unary, so 1 is 1, 2 is 1 1,
3 is 1 1 1, and so forth. The tapes for this machine should be in the form

```
Number A 0 Number B
```

where Number A is bigger than Number B, e.g.

```
1 1 0 1
```

Once you've got a tape, run it through tStart in rule-testing mode, i.e.

```
tStart 1 1 0 1
```

the output is the same format as the input. BTW. a 'N' character is a
blank (i.e. non-defined) space on the tape.

Finally, doing any meaningful calculation with this machine is going to
stress your sendmail's recursion - you might consider upping the recursion
limit by changing MAXRULERECURSION in conf.c in the sendmail source, and
recompiling (at least that works for my sendmail 8.8.8).

Have fun,
Peter

```
# turing machine - starting point, converts input into internal rep. and
# starts at the first state of substraction machine
StStart
R$* $: $>tInput $1
R$* $@ $>tPass $1

# turing machine - move the tape right
StR
RN ! N ! $* M $* $@ $1 ! N ! $2
RN ! N ! $* $@ $1 ! N ! N
R$* ! N ! $* M $* $@ $2 ! $1 ! $3
R$* ! N ! $* $@ $2 ! $1 ! N
R$* ! $* ! $* M $* $@ $3 ! $1 M $2 ! $4
R$* ! $* ! $* $@ $3 ! $1 M $2 ! N

# turing machine - move the tape left
StL
R$* ! $* M $* ! $* $@ $2 ! $3 ! $1 M $4
RN ! N ! $* $@ N ! N ! $1
R$* ! N ! $* $@ N ! N ! $1 M $2
R$* ! $* ! $* $@ $2 ! N ! $1 M $3

# turing machine - convert input of the form X X X X to internal
# tape representation
StInput
R$- $* $@ $1 ! N ! $>tAddMark $2

StAddMark
R$- $+ $@ $1 M $>tAddMark $2

# turing machine - convert internal tape representation to the form
# X X X X
StOutput
R$* ! $* ! $* $: $1 ! $3 ! $>tReverse $2 S
R$* ! $* ! $* $: $1 ! $2 ! $>tStripMark $3
R$* ! $* ! $* $: $1 ! $3 ! $>tStripMark $2
R$* ! $* ! $* $@ $2 $1 $3

StReverse
R$- S $@ $1
R$* M $* M $- S $+ $@ $>tReverse $2 M $3 S $1 M $4
R$* M $* M $- S $@ $>tReverse $2 M $3 S $1
R$* M $* S $+ $@ $2 M $1 M $3
R$* M $* S $@ $2 M $1

StStripMark
R$* M $+ $@ $>tStripMark $1 $2

# state machine for doing subtraction

# turing machine - go past the initial 1's
StPass
R1 $* $@ $>tPassMatchOne 1 $1
R0 $* $@ $>tPassMatchZero 0 $1

StPassMatchOne
R$* $: $>tR $1
R$* $@ $>tPass $1

StPassMatchZero
R$* $: $>tR $1
R$* $@ $>tFind2nd $1

# turing machine - find the start of the 2nd number, chop off a 1, and
# reverse direction
StFind2nd
R0 $* $@ $>tFind2ndMatchZero 0 $1
R1 $* $@ $>tFind2ndMatchOne 0 $1
RN $* $@ $>tFind2ndMatchBlank N $1

StFind2ndMatchZero
R$* $: $>tR $1
R$* $@ $>tFind2nd $1

StFind2ndMatchOne
R$* $: $>tL $1
R$* $@ $>tDelete $1

StFind2ndMatchBlank
R$* $: $>tL $1
R$* $@ $>tOutput $1

# turing machine - reverse the tape till you find a 1, and delete it
StDelete
R0 $* $@ $>tDeleteMatchZero 0 $1
R1 $* $@ $>tDeleteMatchOne 0 $1

StDeleteMatchZero
R$* $: $>tL $1
R$* $@ $>tDelete $1

StDeleteMatchOne
R$* $: $>tR $1
R$* $@ $>tFind2nd $1
```

The original date of posting was 8th of September 1998, and my signature line at the time referred to
an email address on a machine at UWC, presumably one that I was sysadmin of at the time.
