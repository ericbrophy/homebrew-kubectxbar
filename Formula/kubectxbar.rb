class Kubectxbar < Formula
  desc "macOS menu bar app for switching kubectl contexts"
  homepage "https://github.com/ericbrophy/kubectxbar"
  version "0.2.0"
  url "https://github.com/ericbrophy/homebrew-kubectxbar/releases/download/v#{version}/kubectxbar-#{version}-universal.tar.gz"
  sha256 "84e8d040d8b46fb222129cf5d52d158df42b4563c2c5e3cea03e51a07ef7824f"
  license "MIT"

  depends_on :macos
  depends_on macos: :ventura
  depends_on "kubernetes-cli"

  def install
    libexec.install "KubectxBar.app"
    (bin/"kubectxbar").write <<~SH
      #!/bin/bash
      exec "#{libexec}/KubectxBar.app/Contents/MacOS/KubectxBar" "$@"
    SH
    (bin/"kubectxbar").chmod 0755
  end

  service do
    # Run the bundle's binary directly so macOS associates the running
    # process with the .app — surfaces the app icon and display name in
    # Activity Monitor, Force Quit, and Spotlight.
    run [opt_libexec/"KubectxBar.app/Contents/MacOS/KubectxBar"]
    keep_alive true
    log_path var/"log/kubectxbar.log"
    error_log_path var/"log/kubectxbar.log"
  end

  test do
    assert_predicate libexec/"KubectxBar.app/Contents/MacOS/KubectxBar", :exist?
    assert_predicate libexec/"KubectxBar.app/Contents/MacOS/KubectxBar", :executable?
    assert_predicate bin/"kubectxbar", :executable?
    assert_match "KubectxBar",
                 shell_output("/usr/bin/plutil -extract CFBundleName raw " \
                              "#{libexec}/KubectxBar.app/Contents/Info.plist").strip
  end
end
