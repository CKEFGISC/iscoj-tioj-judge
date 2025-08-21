#ifndef TIOJ_MODULES_H_
#define TIOJ_MODULES_H_

#include <filesystem>
#include <format>
#include <cstdlib>

#include <spdlog/spdlog.h>
#include <tioj/paths.h>
#include <tioj/submission.h>

namespace fs = std::filesystem;

void PreBuildCMI();

#endif //TIOJ_MODULES_H_