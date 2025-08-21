#include "modules.h"

void PreBuildCMI() {
    const fs::path original = std::filesystem::current_path();

    fs::create_directories(kBoxRoot / "cmi");
    fs::current_path(kBoxRoot / "cmi");
    system("/usr/bin/env g++-15 -std=c++23 -fmodules -fsearch-include-path -c bits/std.cc");

    fs::current_path(original);
}
