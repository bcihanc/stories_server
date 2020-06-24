FROM google/dart

WORKDIR /app
ADD pubspec.* /app/
RUN pub get --no-precompile
ADD . /app/
RUN pub get --offline --no-precompile
<<<<<<< HEAD
# RUN pub global activate aqueduct
=======
>>>>>>> 462a61759fc14cedafeabfc51de37f34a986f62c

WORKDIR /app
EXPOSE 80

ENTRYPOINT pub run aqueduct:aqueduct serve --port 80
