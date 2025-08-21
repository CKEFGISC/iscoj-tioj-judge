#include "modules.h"

#include <paths.h>

void PreBuildCMIWithStandard(Compiler standard) {
  const fs::path original = fs::current_path();
  const fs::path dest = CompileCMIPath(standard);

  fs::create_directories(dest);
  fs::current_path(dest);

  if (standard == Compiler::GCC_CPP_23) system("/usr/bin/env g++-15 -std=c++23 -O2 -fmodules -fsearch-include-path -c bits/std.cc");

  system(std::format("/usr/bin/env g++-15 -std={} -O2 -fmodules -x c++-system-header -c bits/stdc++.h", standard).c_str());

  fs::current_path(original);
}

void PreBuildCMI() {
  for (const std::vector standards = {Compiler::GCC_CPP_20, Compiler::GCC_CPP_23}; const auto standard : standards) PreBuildCMIWithStandard(standard);
}