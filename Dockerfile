FROM ubuntu:16.04

# A Turing machine based subtractor in sendmail
# for history see
# http://bit.ly/sendmail-turing

# to demo (compute 2 - 1):
# tStart 1 1 0 1

MAINTAINER Peter van Heusden <pvh@sanbi.ac.za>

WORKDIR /etc/mail

RUN set -e && \
 apt-get update && \
 apt-get install -y sendmail

COPY turing.cf /etc/mail/sendmail.cf

# run script to be used by Singularity container
# runs /usr/lib/sendmail -bt
COPY singularity.sh /singularity
RUN chmod a+x /singularity

CMD /singularity
