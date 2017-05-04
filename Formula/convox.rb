class Convox < Formula
  desc "The convox AWS PaaS CLI tool"
  homepage "https://convox.com/"
  url "https://github.com/convox/rack/archive/20170502211928.tar.gz"
  sha256 "f52c25145380c3b57f20c42e241ae2048d83657cfb16db7925e18450ea30c0be"

  bottle do
    cellar :any_skip_relocation
    sha256 "ccafc5da2a76d6a507990b14842ac0cc1d230842239ddedb931fd112bc7d261c" => :sierra
    sha256 "28e75b9b0ec4fd28ff1374fea3633af2a0f7e0da5cdbc7f9c5f9be01633aa175" => :el_capitan
    sha256 "e6bc86e71179acd4fcf0fa3c12fa2f7571e9408da0801997ae440be6e7dec9ff" => :yosemite
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/convox/rack").install Dir["*"]
    system "go", "build", "-ldflags=-X main.Version=#{version}",
           "-o", bin/"convox", "-v", "github.com/convox/rack/cmd/convox"
  end

  test do
    system bin/"convox"
  end
end
