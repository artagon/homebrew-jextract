# homebrew-jextract

**Homebrew tap for Jextract** - OpenJDK's official tool to automatically generate Java bindings from C/C++ library headers without writing JNI code. Part of Project Panama's Foreign Function & Memory API (FFM API). Call native libraries from Java with zero boilerplate.

🚀 **Easy Installation** • ✅ **Multi-Platform** (macOS ARM64/x64, Linux ARM64/x64) • 🔄 **Auto-Updates** • 🔒 **SHA-256 Verified**

[![Release](https://github.com/Artagon/homebrew-jextract/actions/workflows/release.yml/badge.svg)](https://github.com/Artagon/homebrew-jextract/actions/workflows/release.yml)
[![Validate](https://github.com/Artagon/homebrew-jextract/actions/workflows/validate.yml/badge.svg)](https://github.com/Artagon/homebrew-jextract/actions/workflows/validate.yml)
[![License: GPL v2 with Classpath Exception](https://img.shields.io/badge/License-GPL_v2--with--Classpath--Exception-blue.svg)](https://openjdk.java.net/legal/gplv2+ce.html)

## About Jextract

**[Jextract](https://jdk.java.net/jextract/)** is OpenJDK's official tool for automatically generating Java bindings from C library headers, eliminating the need to write manual JNI (Java Native Interface) code. Part of [Project Panama](https://openjdk.org/projects/panama/), jextract bridges the gap between Java and native code through the modern **Foreign Function & Memory (FFM) API** ([JEP 454](https://openjdk.org/jeps/454)).

### 🎯 The Problem Jextract Solves

Traditionally, calling native C/C++ libraries from Java required:
- Writing complex JNI boilerplate code in both Java and C
- Manual memory management and type conversions
- Dealing with platform-specific compilation issues
- Maintaining fragile code that breaks when headers change
- Deep expertise in both Java and native development

**Jextract automates all of this**, parsing C headers with libclang and generating type-safe Java bindings automatically.

### 🚀 What Jextract Provides

- **Zero-Code Native Interop**: Call C functions, access structs, use callbacks - no JNI code required
- **Automatic Code Generation**: Parse `.h` header files → Generate complete Java bindings
- **Type-Safe Memory Access**: Leverage Java's FFM API for safe, structured access to native memory
- **Modern Java Integration**: Works with Java 21+ preview features, graduating to standard in future releases
- **libclang-Powered**: Uses LLVM's libclang for industrial-strength C header parsing
- **Struct & Union Support**: Full support for complex C data structures, nested types, and unions
- **Function Pointers & Callbacks**: Bidirectional interop with native callbacks and function pointers
- **Cross-Platform**: Generate bindings for Windows, macOS, and Linux from the same headers

### 🔧 Real-World Use Cases

#### System Libraries & APIs
```bash
# Generate bindings for POSIX APIs
jextract --source -t org.unix /usr/include/unistd.h

# macOS frameworks
jextract --source -t com.apple.foundation Foundation.h

# Linux system calls
jextract --source -t org.linux /usr/include/sys/socket.h
```

#### Graphics & Media
- **OpenGL/Vulkan**: Direct GPU programming without JNI overhead
- **FFmpeg**: Video/audio processing with native performance
- **SDL2**: Game development with native windowing and input
- **Cairo/Skia**: High-performance 2D graphics rendering

#### Scientific Computing
- **BLAS/LAPACK**: Linear algebra operations at native speed
- **FFTW**: Fast Fourier transforms for signal processing
- **HDF5**: Scientific data format I/O
- **CUDA/ROCm**: GPU-accelerated computing

#### Embedded Systems
- **libusb**: Direct USB device access
- **wiringPi**: Raspberry Pi GPIO control
- **SerialPort APIs**: Industrial device communication

#### Database & Performance
- **SQLite**: Embedded database without JDBC overhead
- **LevelDB/RocksDB**: High-performance key-value stores
- **jemalloc/tcmalloc**: Custom memory allocators

### ⚡ Key Advantages Over Traditional JNI

| Feature | Jextract + FFM API | Traditional JNI |
|---------|-------------------|-----------------|
| **Code Generation** | Automatic from headers | Manual for every function |
| **Type Safety** | Compile-time checked | Runtime errors common |
| **Memory Safety** | Structured, scoped allocation | Manual malloc/free |
| **Performance** | Near-native (no marshalling) | Marshalling overhead |
| **Maintenance** | Regenerate when headers change | Manual updates required |
| **Learning Curve** | Java developers only | Requires C/C++ expertise |
| **Debugging** | Pure Java stack traces | Mixed Java/native traces |
| **Build Complexity** | No native compilation | Platform-specific builds |

### 💡 Technical Highlights

- **Project Panama Integration**: Part of OpenJDK's initiative to improve Java-native interoperability
- **Foreign Function & Memory API**: Modern replacement for JNI with improved safety and performance
- **MemorySegment API**: Safe, deterministic memory management without garbage collection
- **Arena-Based Allocation**: Automatic cleanup of native resources using try-with-resources
- **SymbolLookup**: Runtime function discovery from shared libraries
- **MethodHandle-Based**: Uses Java's method handles for efficient, type-safe native calls
- **Varargs Support**: Handles C variadic functions like printf
- **Macro Expansion**: Processes C preprocessor macros and constants

### 🎓 Who Should Use Jextract?

- **Java Developers** needing to call native libraries without learning JNI
- **Systems Programmers** who want to use Java for low-level programming
- **Library Authors** creating Java wrappers for C/C++ libraries
- **Scientific Computing** developers requiring native performance with Java productivity
- **Game Developers** interfacing with graphics and audio libraries
- **IoT/Embedded** engineers working with hardware interfaces
- **Performance Engineers** optimizing critical paths with native code

### 📋 Requirements

- **Java 21 or later** (FFM API is in preview, graduating to standard in future releases)
- **`--enable-preview`** flag required for compilation and execution
- **C headers** for the libraries you want to bind
- **Target library** installed on the system (e.g., `.so` on Linux, `.dylib` on macOS)

### 🔗 Part of Project Panama

Jextract is one component of [Project Panama](https://openjdk.org/projects/panama/), OpenJDK's comprehensive effort to improve Java's connection to native code:

- **Foreign Function API**: Call native functions without JNI ([JEP 454](https://openjdk.org/jeps/454))
- **Foreign Memory API**: Safe native memory access ([JEP 454](https://openjdk.org/jeps/454))
- **Vector API**: SIMD operations for parallel computation ([JEP 469](https://openjdk.org/jeps/469))
- **Jextract**: Automatic binding generation (this tool)

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

### Official Documentation
- **[Jextract Home](https://jdk.java.net/jextract/)** - Official download page
- **[JEP 454: Foreign Function & Memory API](https://openjdk.org/jeps/454)** - The underlying API used by jextract
- **[Panama Project](https://openjdk.org/projects/panama/)** - Parent project for foreign function support

### Getting Started
- **[Jextract Samples](https://github.com/openjdk/jextract)** - Example code and documentation
- **[Foreign Function & Memory API Guide](https://docs.oracle.com/en/java/javase/22/core/foreign-function-and-memory-api.html)** - Official guide for using the FFM API

### Technical Details
- Uses libclang to parse C header files
- Generates Java code using the Foreign Function & Memory API
- Requires JDK 21 or later with preview features enabled

### Important Notes
- Jextract generates code that uses preview features, requiring the `--enable-preview` flag
- The generated bindings are specific to the platform and C library version
- Regenerate bindings when native library headers change

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
