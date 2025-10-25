# homebrew-jextract

Homebrew tap for Jextract - the tool to mechanically generate Java bindings from native library headers. Includes automated updates, CI/CD, and support for both macOS and Linux.

[![Release](https://github.com/Artagon/homebrew-jextract/actions/workflows/release.yml/badge.svg)](https://github.com/Artagon/homebrew-jextract/actions/workflows/release.yml)
[![Validate](https://github.com/Artagon/homebrew-jextract/actions/workflows/validate.yml/badge.svg)](https://github.com/Artagon/homebrew-jextract/actions/workflows/validate.yml)
[![License: GPL v2 with Classpath Exception](https://img.shields.io/badge/License-GPL_v2--with--Classpath--Exception-blue.svg)](https://openjdk.java.net/legal/gplv2+ce.html)

## About Jextract

[Jextract](https://jdk.java.net/jextract/) is a tool which mechanically generates Java bindings from native library headers. This means you can call native C libraries from Java without writing any JNI code.

### What Does Jextract Provide?

- **Automatic Java Bindings**: Generate Java code to call C libraries directly
- **Type-Safe Access**: Strong typing for native library interfaces
- **Foreign Function & Memory API**: Uses modern Java FFM API (JEP 454)
- **Header Parsing**: Parses C header files using libclang
- **No Manual JNI**: Eliminates the need for hand-written JNI code

### Key Benefits

- **Productivity**: Generate bindings automatically instead of writing JNI by hand
- **Safety**: Type-safe access to native code through Java's Foreign Function & Memory API
- **Maintainability**: Regenerate bindings when native library headers change
- **Performance**: Direct access to native code with minimal overhead

### Use Cases

Jextract is particularly useful for:
- Interfacing with existing C libraries from Java
- Systems programming in Java
- Calling OS-specific APIs
- Wrapping native libraries for Java applications
- High-performance computing requiring native code access

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
/Library/Java/JavaVirtualMachines/jextract-25.jdk/bin/jextract --version
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
