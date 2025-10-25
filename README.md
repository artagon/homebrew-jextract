# homebrew-jextract

Homebrew tap for Jextract - the tool to mechanically generate Java bindings from native library headers. Includes automated updates, CI/CD, and support for both macOS and Linux.

[![Release](https://github.com/Artagon/homebrew-jextract/actions/workflows/release.yml/badge.svg)](https://github.com/Artagon/homebrew-jextract/actions/workflows/release.yml)
[![Validate](https://github.com/Artagon/homebrew-jextract/actions/workflows/validate.yml/badge.svg)](https://github.com/Artagon/homebrew-jextract/actions/workflows/validate.yml)
[![License: GPL v2 with Classpath Exception](https://img.shields.io/badge/License-GPL_v2--with--Classpath--Exception-blue.svg)](https://openjdk.java.net/legal/gplv2+ce.html)

## About Jextract

[Jextract](https://jdk.java.net/jextract/) is a tool which **mechanically generates Java bindings from native library headers**. Part of OpenJDK's Project Panama, it eliminates the need for manual JNI code by automatically creating type-safe Java interfaces to C libraries using the Foreign Function & Memory API (JEP 454).

### What Does Jextract Provide?

- **Automatic Java Bindings**: Generate Java code to call C libraries directly from header files
- **Type-Safe Access**: Strong typing for native library interfaces with compile-time safety
- **Foreign Function & Memory API**: Uses modern Java FFM API ([JEP 454](https://openjdk.org/jeps/454)) instead of JNI
- **Header Parsing**: Leverages libclang C API for accurate header file parsing
- **No Manual JNI**: Eliminates hand-written JNI boilerplate and marshalling code
- **Cross-Platform**: Supports macOS (ARM64/x64), Linux (ARM64/x64), and Windows

### Key Benefits

- **Productivity**: Generate bindings automatically instead of writing thousands of lines of JNI
  - One command replaces hours of manual coding
  - Automatically handles complex C types and structures
  - Regenerate bindings instantly when headers change

- **Safety**: Modern FFM API provides memory-safe access without JNI pitfalls
  - Compile-time type checking
  - No native crashes from incorrect marshalling
  - Memory segments with automatic bounds checking
  - Resource management with try-with-resources

- **Performance**: Direct native calls without JNI overhead
  - Zero-copy memory access
  - Optimized by HotSpot JIT
  - Minimal marshalling overhead
  - Stack-based memory allocation

- **Maintainability**: Cleaner architecture and easier updates
  - Pure Java code, no C glue code
  - Version control friendly (no binary artifacts)
  - Easy to regenerate when libraries update
  - Clear correspondence to C APIs

### What is Project Panama?

[Project Panama](https://openjdk.org/projects/panama/) is an OpenJDK project aimed at improving and enriching the connections between the Java virtual machine and well-defined but "foreign" (non-Java) APIs, including C, C++, and other native libraries. Jextract is a key component that makes Panama practical for real-world use.

**Panama provides:**
- **Foreign Function API**: Call native functions without JNI
- **Foreign Memory API**: Direct memory access outside the Java heap
- **Jextract Tool**: Automatic binding generation from C headers
- **Vector API**: SIMD operations for high-performance computing

### Use Cases

Jextract is particularly valuable for:

- **System Libraries**: Access OS-specific APIs (Windows API, POSIX, etc.)
- **Legacy C Libraries**: Modernize Java integration with existing C codebases
- **High-Performance Computing**: Direct access to optimized native libraries (BLAS, LAPACK, etc.)
- **Graphics & Media**: Interface with OpenGL, Vulkan, FFmpeg, SDL
- **Embedded Systems**: Java on resource-constrained devices needing native access
- **Scientific Computing**: Integrate with domain-specific C/C++ libraries
- **Game Development**: Access to native game engines and frameworks

## Quick Start

### Formula Installation (macOS/Linux) - Recommended

```bash
brew tap Artagon/jextract
brew install jextract
```

The formula installation creates symlinks in your Homebrew bin directory, making jextract available in your PATH.

### Cask Installation (macOS)

```bash
brew tap Artagon/jextract
brew install --cask jextract
```

The cask installation places jextract in `/Library/Java/JavaVirtualMachines/jextract-25.jdk` and integrates with macOS's Java management system.

## Current Version

**Jextract Build 25-jextract+1-1** (Released: 2025-09-25)

Based on JDK 25.

## Features

- **Automatic Updates**: Weekly checks for new jextract builds with automated formula/cask updates
- **Multi-Platform Support**:
  - macOS: ARM64 (Apple Silicon) and x64 (Intel)
  - Linux: ARM64 (aarch64) and x64
- **CI/CD Validation**: Automated testing on every commit across all supported platforms
- **GitHub Releases**: Automatic release creation when new versions are detected
- **Flexible Installation**: Choose between cask (macOS system integration) or formula (Homebrew-managed) installation
- **Integrity Verification**: SHA-256 checksum validation for all downloads

## Platform Support

| Platform | Architecture | Cask | Formula | Status |
|----------|-------------|------|---------|--------|
| macOS 13+ | ARM64 (Apple Silicon) | ✅ | ✅ | Fully Tested |
| macOS 13+ | x64 (Intel) | ✅ | ✅ | Fully Tested |
| Linux | ARM64 (aarch64) | ❌ | ✅ | Fully Tested |
| Linux | x64 | ❌ | ✅ | Fully Tested |

**Note:** Cask installation is macOS-only and integrates with the system's Java framework at `/Library/Java/JavaVirtualMachines/`. Formula installation works on both macOS and Linux, placing files in the Homebrew prefix.

## Usage

### Basic Usage

After installation, jextract will be available in your PATH:

```bash
# Check version
jextract --version

# Generate bindings for a C library
jextract --source --output src -t org.example myheader.h

# Get help
jextract --help
```

### Example: Binding to stdio.h

```bash
# Generate Java bindings for stdio.h
jextract --source -t org.unix -I /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include /usr/include/stdio.h

# Use the generated bindings in your Java code
javac --enable-preview --release 25 YourCode.java
java --enable-preview YourCode
```

### Verifying Installation

**For formula installation:**
```bash
which jextract
# Should show: /opt/homebrew/bin/jextract (or similar)
```

**For cask installation:**
```bash
/Library/Java/JavaVirtualMachines/jextract-25.jdk/Contents/Home/bin/jextract --version
```

## Updating

The tap is automatically updated with new jextract builds. To update to the latest version:

```bash
brew update
brew upgrade jextract  # or brew upgrade --cask jextract
```

## Issue Reporting

Found a problem? [Open an issue](https://github.com/Artagon/homebrew-jextract/issues/new/choose) using our issue templates.

## Automated Updates

This repository uses GitHub Actions to automatically maintain the latest jextract builds:

### Update Workflow
1. **Weekly Checks** (Sundays at 12:00 UTC): Automated script checks [jdk.java.net/jextract](https://jdk.java.net/jextract/) for new builds
2. **Multi-Platform Download**: Downloads and verifies binaries for all supported platforms:
   - macOS: ARM64 and x64
   - Linux: ARM64 and x64
3. **SHA-256 Verification**: Calculates checksums for all platform binaries
4. **Automated PR Creation**: Creates pull request with updated formula/cask when new version detected
5. **CI/CD Validation**: Runs comprehensive tests across all platforms:
   - Syntax validation for Ruby code
   - Installation tests on macOS 13, macOS 14, Ubuntu 22.04, Ubuntu 24.04
   - Runtime verification (jextract version check)
6. **Auto-Merge**: PR automatically merges after passing all tests
7. **GitHub Release**: Creates tagged release with version notes

### Manual Trigger
You can manually trigger an update check:
```bash
# Via GitHub CLI
gh workflow run update.yml -R Artagon/homebrew-jextract
```

Or visit the [Actions tab](https://github.com/Artagon/homebrew-jextract/actions/workflows/update.yml) and click "Run workflow".

## Jextract Resources

### Official Documentation & Specifications

#### Core Documentation
- **[Jextract Official Home](https://jdk.java.net/jextract/)** - Official download page and primary documentation
- **[Jextract User Guide](https://github.com/openjdk/jextract/blob/master/doc/GUIDE.md)** - Comprehensive guide on using jextract
- **[Foreign Function & Memory API Guide (Oracle)](https://docs.oracle.com/en/java/javase/25/core/foreign-function-and-memory-api.html)** - Official guide for the FFM API
- **[Dev.java FFM Tutorial](https://dev.java/learn/ffm/)** - Interactive tutorial for Foreign Function & Memory API

#### JEP Specifications
- **[JEP 454: Foreign Function & Memory API](https://openjdk.org/jeps/454)** - Final specification (JDK 22+)
- **[JEP 442: Foreign Function & Memory API (Third Preview)](https://openjdk.org/jeps/442)** - JDK 21
- **[JEP 434: Foreign Function & Memory API (Second Preview)](https://openjdk.org/jeps/434)** - JDK 20
- **[JEP 424: Foreign Function & Memory API (Preview)](https://openjdk.org/jeps/424)** - JDK 19

### Official Repository
- **[openjdk/jextract](https://github.com/openjdk/jextract)** - Official GitHub repository (465+ stars)
  - Source code and build instructions
  - Issue tracker and discussions
  - Sample code and tests
  - Requires JDK 23+ and LLVM 13.0.0+ to build

### Project Information
- **[OpenJDK Project Panama](https://openjdk.org/projects/panama/)** - Parent project for foreign function support
- **[Project Panama Wiki](https://wiki.openjdk.org/display/panama)** - Design documents and project status
- **[Code Tools Project](https://openjdk.org/projects/code-tools)** - Jextract's home project

### Guides & Tutorials

#### Beginner-Friendly
- **[Guide to Java Project Panama (Baeldung)](https://www.baeldung.com/java-project-panama)** - Comprehensive beginner's guide
- **[Project Panama for Newbies (Part 1)](https://foojay.io/today/project-panama-for-newbies/)** - Introduction series
- **[Project Panama for Newbies (Part 2)](https://foojay.io/today/project-panama-for-newbies-part-2/)** - Continuation
- **[Project Panama for Newbies (Part 3)](https://foojay.io/today/project-panama-for-newbies-part-3/)** - Advanced topics

#### In-Depth Tutorials
- **[From C to Java Code using Panama (SAP)](https://community.sap.com/t5/technology-blog-posts-by-sap/from-c-to-java-code-using-panama/ba-p/13578395)** - Enterprise perspective
- **[From C to Java Code using Panama (Nerdless)](https://mostlynerdless.de/blog/2023/12/11/from-c-to-java-code-using-panama/)** - Detailed walkthrough
- **[Writing C Code in Java (Foojay)](https://foojay.io/today/writing-c-code-in-java/)** - Practical examples
- **[Building Project Panama's jextract tool](https://foojay.io/today/building-project-panamas-jextract-tool-by-yourself/)** - Build from source guide

#### Specialized Topics
- **[Accessing Native Code in Java (Azul)](https://www.azul.com/blog/accessing-native-code-in-java-with-project-panama/)** - Performance considerations
- **[Does Java Finally Have a Better Alternative to JNI? (Okta)](https://developer.okta.com/blog/2022/04/08/state-of-ffi-java)** - FFM vs JNI comparison

### Videos & Presentations

#### Conference Talks
- **[JavaOne 2025: Function and Memory Access in Pure Java](https://www.infoq.com/news/2025/04/foreign-function-minborg/)** - Per-Åke Minborg (Oracle)
  - Latest developments in FFM API
  - Replacing JNI with pure Java
  - Performance comparisons

- **[FOSDEM'22: Java Applications Meet Native Libraries](https://www.youtube.com/results?search_query=java+foreign+function+memory+api+fosdem)** - Testing preview features
  - 3rd preview of Foreign Function & Memory API (Java 21)
  - Practical demonstrations

#### Inside Java
- **[Project Panama and jextract (Inside.java)](https://inside.java/2020/10/06/jextract/)** - Official OpenJDK blog post
  - Historical context and evolution
  - Design decisions

### Community Resources

#### Mailing Lists & Discussion
- **[jextract-dev Mailing List](mailto:jextract-dev@openjdk.org)** - Development discussions (subscription required)
- **[panama-dev Mailing List](https://mail.openjdk.org/mailman/listinfo/panama-dev)** - Panama project discussions
- **[GitHub Discussions](https://github.com/Artagon/homebrew-jextract/discussions)** - Community Q&A for this tap

#### Support Channels
- **[Download Support](mailto:download-help@openjdk.org)** - File download issues
- **[Stack Overflow: jextract](https://stackoverflow.com/questions/tagged/jextract)** - Community Q&A
- **[Stack Overflow: project-panama](https://stackoverflow.com/questions/tagged/project-panama)** - Panama questions

### Example Projects & Code Samples

#### Official Examples
- **[openjdk/jextract Samples](https://github.com/openjdk/jextract/tree/master/samples)** - Official sample code
  - Basic C library bindings
  - OpenGL examples
  - SDL integration

#### Community Examples
- **[Panama4Newbies](https://github.com/carldea/panama4newbies)** - Comprehensive tutorial project by Carl Dea
  - Step-by-step examples
  - SDL, OpenGL, and Python integration
  - Practical real-world scenarios

#### Stack Overflow Examples
- **[Calling C from Java 17](https://stackoverflow.com/questions/69321128/)** - Using JEP 412
- **[Traversing Structs in Java 22](https://stackoverflow.com/questions/78523567/)** - Working with C structures

### Technical Specifications

#### Requirements
- **Build Requirements**:
  - JDK 23 or higher
  - LLVM/Clang 13.0.0 or later
  - Gradle 8.11.1+ (included via wrapper)

- **Runtime Requirements**:
  - JDK 21 or later
  - Preview features must be enabled with `--enable-preview` flag

#### How Jextract Works
- **Header Parsing**: Uses libclang C API to parse native library headers
- **Binding Generation**: Creates Java source code with:
  - Method handles for native function calls
  - Memory layouts for native structures
  - Type-safe access patterns
- **FFM API Integration**: Generated code uses Foreign Function & Memory API
  - No JNI overhead
  - Direct memory access
  - Efficient native calls

#### Platform-Specific Notes
- **macOS**: May require quarantine attribute removal (Catalina+)
  ```bash
  xattr -d com.apple.quarantine /path/to/jextract
  ```
- **Linux**: Ensure GLIBC 2.27+ for pre-built binaries
- **Windows**: Requires MSVC runtime for native library support

### Important Notes
- Jextract generates code that uses **preview features**, requiring the `--enable-preview` flag
- The generated bindings are **platform-specific** and tied to the C library version
- **Regenerate bindings** when native library headers change
- Generated code targets the **JDK version** that jextract was built with
- Consider **security implications** when exposing native code to Java

## License

This tap is distributed under the same license as OpenJDK (GPL-2.0 with Classpath Exception).

## Disclaimer

Jextract is an early-access tool provided for testing and development purposes. The tool and its generated APIs may change in future releases. For production use, consider the maturity level and stability requirements of your project.

**Important:** Jextract requires preview features to be enabled with the `--enable-preview` flag. The APIs and tooling are subject to change in future releases.

## Links

- [Jextract Downloads](https://jdk.java.net/jextract/)
- [OpenJDK Project Panama](https://openjdk.org/projects/panama/)
- [JEP 454: Foreign Function & Memory API](https://openjdk.org/jeps/454)
- [Jextract GitHub](https://github.com/openjdk/jextract)
- [Homebrew Documentation](https://docs.brew.sh/)
