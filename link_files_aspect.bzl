"""
    This aspect iterates through libraries from CcInfo and put them to the OutputGroupInfo
"""

def _link_files_aspect_impl(target, aspect_ctx):
    link_files = []

    if CcInfo in target:
        linking_context = target[CcInfo].linking_context

        for linker_input in linking_context.linker_inputs.to_list():
            for library in linker_input.libraries:

                if library.pic_static_library:
                    link_files.append(library.pic_static_library)

                if library.dynamic_library:
                    link_files.append(library.interface_library if library.interface_library else library.dynamic_library)
                    continue

                if library.static_library:
                    link_files.append(library.static_library)
                    continue

                if library.objects:
                    link_files += library.objects
                    continue

    return [
        OutputGroupInfo(
            link_files = depset(direct = link_files),
        ),
    ]

link_files_aspect = aspect(
    implementation = _link_files_aspect_impl,
    attr_aspects = [],
    attrs = {},
)