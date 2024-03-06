include $(config_dir)base/base.mk

this_cxxflags += -O3

this_lint_cmd = $(prorab_lint_cmd_clang_tidy)

# WORKAROUND: Use clang++ instead of g++ because Debian bookworm's version of g++ has bug,
# it gives compiler warnings (which are turned to errors by -Werror) when using -O3 optimization
this_cxx := clang++
this_cc := clang

# WORKAROUND: on ubuntu jammy dpkg-buildpackage passes -ffat-lto-objects compilation flag
# which is not supported by clang and clang-tidy complains about it:
# error: optimization flag '-ffat-lto-objects' is not supported [clang-diagnostic-ignored-optimization-argument]
# Thus, suppress this warning.
this_cxxflags += -Wno-ignored-optimization-argument

ifeq ($(os),macosx)
    # WORKAROUND:
    # clang-tidy on macos doesn't use /usr/local/include as default place to
    # search for header files, so we add it explicitly
    this_cxxflags += -I /usr/local/include
endif
