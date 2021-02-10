FROM alpine:edge

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ bazel3 \
    && bazel --version
# bazel works!
# Until we do anything that upgrades musl...
RUN apk add --no-cache --virtual .build-deps g++ \
    && apk del --no-cache .build-deps
# I'm pretty sure the above has no lasting effect *except* upgrading musl.
# (We could just upgrade musl, but I want to make the point that musl will get incidentally upgraded when you try to do almost anything else.)
RUN bazel --version
# And bazel doesn't work anymore.
# If we do the thing that upgrades musl *before* installing bazel3, then bazel immediately doesn't work.
# Granted, part of the problem is that apk add musl=1.2.2_pre6-r0 doesn't work --- we can't downgrade musl. But even if we could, it might not be a good idea if other things expect the upgraded musl.

