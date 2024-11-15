# transition
def _platform_switch_transition_impl(_, attr):
    if not hasattr(attr, "platforms"):
        fail("mandatory attribure `platforms` does not exist")

    return [
        {"//command_line_option:platforms": str(platform)}
        for platform in attr.platforms
    ]

_platform_switch_transition = transition(
    implementation = _platform_switch_transition_impl,
    inputs = [],
    outputs = [
        "//command_line_option:platforms",
    ],
)

# rule
def _platform_switch_impl(ctx):
    return DefaultInfo(files = depset(ctx.files.src))

platform_switch = rule(
    implementation = _platform_switch_impl,
    attrs = {
        "src": attr.label(
            cfg = _platform_switch_transition
        ),
        "platforms": attr.label_list(
            mandatory = True,
        ),
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        )
    }
)
