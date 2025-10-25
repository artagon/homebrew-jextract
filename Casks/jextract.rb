cask "jextract" do
  arch arm: "aarch64", intel: "x64"

  version "25-jextract+1-1,1"
  # Installs to: /Library/Java/JavaVirtualMachines/jextract-25.jdk
  # Supports: macOS ARM64 (Apple Silicon) and x64 (Intel)
  sha256 arm:   "6783d2ba7f686ee636b9542525ee06b7bd096dfca294538613b877a4b5a057da",
         intel: "62fd0453349b8eb48f083d2fb9c5f2ab255f894eaa8c658221366f363c7e91b9"

  url "https://download.java.net/java/early_access/jextract/25/#{version.csv.second}/openjdk-#{version.csv.first}_macos-#{arch}_bin.tar.gz"
  name "Jextract"
  desc "Tool to mechanically generate Java bindings from native library headers"
  homepage "https://jdk.java.net/jextract/"

  postflight do
    require "pathname"

    staged_root = staged_path.realpath
    candidates = Dir["#{staged_root}/jextract-*"]
    odie "Expected exactly one jextract directory in #{staged_root}, found #{candidates.length}" if candidates.length != 1

    jextract_src = Pathname(candidates.first).realpath
    odie "Staged jextract directory #{jextract_src} is not a directory" unless jextract_src.directory?
    odie "Resolved jextract path escapes staging area" unless jextract_src.to_s.start_with?(staged_root.to_s)

    jextract_target = Pathname("/Library/Java/JavaVirtualMachines/jextract-25.jdk")
    if jextract_target.exist?
      ohai "Removing existing jextract at #{jextract_target}"
      removal = system_command "/bin/rm",
                               args: ["-rf", jextract_target.to_s],
                               sudo: true
      odie "Failed to remove existing jextract at #{jextract_target}" unless removal.success?
    end

    ohai "Installing Jextract to #{jextract_target}"
    install = system_command "/usr/bin/ditto",
                             args: ["--noqtn", jextract_src.to_s, jextract_target.to_s],
                             sudo: true
    odie "Failed to install jextract to #{jextract_target}" unless install.success?
  end

  uninstall delete: "/Library/Java/JavaVirtualMachines/jextract-25.jdk"
end
