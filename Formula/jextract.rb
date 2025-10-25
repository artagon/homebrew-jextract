class Jextract < Formula
  desc "Tool to mechanically generate Java bindings from native library headers"
  homepage "https://jdk.java.net/jextract/"
  version "25-jextract+1-1"
  on_macos do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jextract/25/1/openjdk-25-jextract+1-1_macos-aarch64_bin.tar.gz"
      sha256 "6783d2ba7f686ee636b9542525ee06b7bd096dfca294538613b877a4b5a057da"
    else
      url "https://download.java.net/java/early_access/jextract/25/1/openjdk-25-jextract+1-1_macos-x64_bin.tar.gz"
      sha256 "62fd0453349b8eb48f083d2fb9c5f2ab255f894eaa8c658221366f363c7e91b9"
    end
  end
  on_linux do
    if Hardware::CPU.arm?
      url "https://download.java.net/java/early_access/jextract/25/1/openjdk-25-jextract+1-1_linux-aarch64_bin.tar.gz"
      sha256 "75a199a05e5edade798600a175f8897e711330338f7d8d2da5fff18d707d665e"
    else
      url "https://download.java.net/java/early_access/jextract/25/1/openjdk-25-jextract+1-1_linux-x64_bin.tar.gz"
      sha256 "d826d366b5db8edbed9cfef3779e45e43ba496ca2166b8f70cdaf81ee90c0b1e"
    end
  end
  def install
    # Install directly to prefix to preserve relative paths for bundled runtime
    # The jextract script expects to find runtime/bin/java at ../runtime/bin/java
    prefix.install Dir["*"]

    # Create shell environment configuration files
    (prefix/"etc/profile.d").mkpath
    (prefix/"etc/profile.d/jextract.sh").write <<~EOS
      # jextract environment configuration
      export JEXTRACT_HOME="#{prefix}"
      case ":$PATH:" in
        *:"#{bin}":*) ;;
        *) export PATH="$PATH:#{bin}" ;;
      esac
    EOS

    (prefix/"share/zsh/site-functions").mkpath
    (prefix/"share/zsh/site-functions/jextract.zsh").write <<~EOS
      # jextract environment configuration
      export JEXTRACT_HOME="#{prefix}"
      case ":$PATH:" in
        *:"#{bin}":*) ;;
        *) export PATH="$PATH:#{bin}" ;;
      esac
    EOS

    (prefix/"share/fish/vendor_conf.d").mkpath
    (prefix/"share/fish/vendor_conf.d/jextract.fish").write <<~EOS
      # jextract environment configuration
      set -gx JEXTRACT_HOME "#{prefix}"
      fish_add_path "#{bin}"
    EOS
  end

  def caveats
    <<~EOS
      To automatically configure your shell environment for jextract, add the following to your shell profile:

      For Bash (~/.bash_profile or ~/.bashrc):
        source #{prefix}/etc/profile.d/jextract.sh

      For Zsh (~/.zshrc):
        source #{prefix}/share/zsh/site-functions/jextract.zsh

      For Fish (~/.config/fish/config.fish):
        source #{prefix}/share/fish/vendor_conf.d/jextract.fish

      This will set JEXTRACT_HOME and ensure jextract is in your PATH.
    EOS
  end
  test do
    output = shell_output("#{bin}/jextract --version 2>&1")
    assert_match "jextract", output.downcase
  end
end
