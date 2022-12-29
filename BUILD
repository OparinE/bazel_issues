cc_library(
    name = "foo",
    srcs = ["foo.cpp"],
    deps = [":bar",],
    linkstatic = True,
    visibility = ["//visibility:public"],
)

cc_library(
    name = "bar",
    srcs = ["bar.cpp"],
    linkstatic = True,
    visibility = ["//visibility:public"],
)
