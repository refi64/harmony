FROM perl:5.28.0-slim AS builder

ENV LOG4PERL_CONFIG_FILE=log4perl-json.conf

ENV PORT=8000

# we run a loopback logging server on this TCP port.
ENV LOGGING_PORT=5880

RUN apt-get update
RUN apt-get install -y build-essential curl
RUN cpanm --notest Module::CPANfile App::cpm

WORKDIR /app
COPY Makefile.PL Bugzilla.pm gen-cpanfile.pl /app/

RUN perl Makefile.PL
RUN make cpanfile
RUN apt-get install -y libexpat-dev
RUN cpm install

RUN perl checksetup.pl --no-database --default-localconfig && \
    rm -rf /app/data /app/localconfig && \
    mkdir /app/data

EXPOSE $PORT

ENTRYPOINT ["/app/bugzilla.pl"]
CMD ["daemon"]
