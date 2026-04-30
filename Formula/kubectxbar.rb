class Kubectxbar < Formula
  desc "macOS menu bar app for switching kubectl contexts"
  homepage "https://github.com/ericbrophy/kubectxbar"
  version "0.1.0"
  url "https://github.com/ericbrophy/homebrew-kubectxbar/releases/download/v#{version}/kubectxbar-#{version}.tar.gz"
  sha256 "916023aea48f67391c5eb4d83d5f964c304a3e906dd72785482fb617b7056aa6"
  license "MIT"

  depends_on :macos
  depends_on macos: :ventura
  depends_on "kubernetes-cli"

  def install
    bin.install "KubectxBar" => "kubectxbar"
  end

  service do
    run [opt_bin/"kubectxbar"]
    keep_alive true
    log_path var/"log/kubectxbar.log"
    error_log_path var/"log/kubectxbar.log"
  end

  test do
    assert_predicate bin/"kubectxbar", :exist?
    assert_predicate bin/"kubectxbar", :executable?
  end
end
