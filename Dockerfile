FROM google/dart

WORKDIR /app
ADD pubspec.* /app/
RUN pub get --no-precompile
ADD . /app/
RUN pub get --offline --no-precompile
# RUN pub global activate aqueduct

WORKDIR /app
EXPOSE 80

ENTRYPOINT pub run aqueduct:aqueduct serve --port 80