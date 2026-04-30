class Kubectxbar < Formula
  desc "macOS menu bar app for switching kubectl contexts"
  homepage "https://github.com/ericbrophy/kubectxbar"
  url "https://github.com/ericbrophy/kubectxbar/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"
  head "https://github.com/ericbrophy/kubectxbar.git", branch: "main"

  depends_on xcode: ["15.0", :build]
  depends_on :macos
  depends_on macos: :ventura
  depends_on "kubernetes-cli"

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/KubectxBar" => "kubectxbar"
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
