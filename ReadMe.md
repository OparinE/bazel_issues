# Issue description

There is a bazel project with turning ON remote caching.
Some targets are build using aspect, which provides `OutputGroupInfo` for `--output_groups` command option.

All requested generated files preset when we build target without remote caching.
And we have output files miss for files from `--output_groups` when we build with cache hits and remote caching.

Caching server starts by:
`./bazel-remote-2.3.9-linux-x86_64 --dir=/tmp/bazel_cache --max_size=1`

Two build scenarios:

1) `bazel build //:foo -s --show_result=100 --output_groups=+link_files --aspects=//:link_files_aspect.bzl%link_files_aspect`

Result:
libfoo.a, libbar.a exist.

2) `bazel build //:foo --remote_cache=http://127.0.0.1:8080 --remote_download_toplevel -s --show_result=100 --output_groups=+link_files --aspects=//:link_files_aspect.bzl%link_files_aspect`

Result:

```py
Aspect //:link_files_aspect.bzl%link_files_aspect of //:foo up-to-date:
  bazel-bin/libfoo.a
  bazel-bin/libbar.a
INFO: 7 processes: 4 remote cache hit, 3 internal.
```

is printed. However there is no `bazel-bin/libbar.a`.
