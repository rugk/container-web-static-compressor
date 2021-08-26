# Container Web Static Compressor

An "oneshot" container to recursively compress files statically with these compression algorithms:
* [gzip](https://en.wikipedia.org/wiki/Gzip) (via [gzipper](https://github.com/gios/gzipper))
* [brotli](https://en.wikipedia.org/wiki/Brotli) (via [gzipper](https://github.com/gios/gzipper))
* [zstd](https://facebook.github.io/zstd/) (via the official CLI client)

Always using the highest and best compression (that does not affect the decompression too badly).

The output is modified in place. Please use a webserver of your choice (ideally of course one that supports the static file delivery, like [caddy](https://caddyserver.com/docs/caddyfile/directives/file_server)) to serve these files.

## Arguments

* `COMPRESSOR_DIRECTORY` – you can use this to specify the directory to compress as an environmental variable

Alternatively, you can pass the first parameter as an argument to the container and it compresses this directory.
Only one directory can (recursively) be provided, currently.

If no arguments are passed, `/app` is the directory assumed it tries to compress.

## Example usage

This example uses [`podman`](https://podman.io/), but you can replace the command with `docker` and that should work, too.

It also outputs the files when running the container:
```
podman run -v $PWD/app:/app:Z container-web-static-compressor:latest /app
```

## Build it by yourself

```
podman build . -t container-web-static-compressor:latest
```
