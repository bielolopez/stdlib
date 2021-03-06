#/
# @license Apache-2.0
#
# Copyright (c) 2018 The Stdlib Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#/

# VARIABLES #

# Define the path to a script for compiling a C++ example:
compile_cpp_example_bin := $(TOOLS_DIR)/scripts/compile_cpp_example


# RULES #

#/
# Runs C++ examples consecutively.
#
# ## Notes
#
# -   The recipe delegates to local Makefiles which are responsible for actually compiling and running the respective examples.
# -   This rule is useful when wanting to glob for C++ examples files (e.g., run all C++ examples for a particular package).
#
#
# @param {string} [EXAMPLES_FILTER] - file path pattern (e.g., `.*/math/base/special/abs/.*`)
# @param {string} [CXX_COMPILER] - C++ compiler (e.g., `g++`)
#
# @example
# make examples-cpp
#
# @example
# make examples-cpp EXAMPLES_FILTER=.*/strided/common/.*
#/
examples-cpp:
	$(QUIET) $(FIND_CPP_EXAMPLES_CMD) | grep '^[\/]\|^[a-zA-Z]:[/\]' | while read -r file; do \
		echo ""; \
		echo "Running example: $$file"; \
		cd `dirname $$file` && $(MAKE) clean && \
		OS="$(OS)" \
		NODE="$(NODE)" \
		NODE_PATH="$(NODE_PATH)" \
		CXX_COMPILER="$(CXX)" \
		"${compile_cpp_example_bin}" $$file && \
		$(MAKE) run || exit 1; \
	done

.PHONY: examples-cpp

#/
# Runs a specified list of C++ examples consecutively.
#
# ## Notes
#
# -   The recipe delegates to local Makefiles which are responsible for actually compiling and running the respective examples.
# -   This rule is useful when wanting to run a list of C++ examples files generated by some other command (e.g., a list of changed C++ examples files obtained via `git diff`).
#
#
# @param {string} FILES - list of C++ example file paths
# @param {string} [CXX_COMPILER] - C++ compiler (e.g., `g++`)
#
# @example
# make examples-cpp-files FILES='/foo/example.cpp /bar/example.cpp'
#/
examples-cpp-files:
	$(QUIET) for file in $(FILES); do \
		echo ""; \
		echo "Running example: $$file"; \
		cd `dirname $$file` && $(MAKE) clean && \
		OS="$(OS)" \
		NODE="$(NODE)" \
		NODE_PATH="$(NODE_PATH)" \
		CXX_COMPILER="$(CXX)" \
		"${compile_cpp_example_bin}" $$file && \
		$(MAKE) run || exit 1; \
	done

.PHONY: example-cpp-files
