class Unison24815 < Formula
  desc "File synchronization tool for OSX"
  homepage "https://www.cis.upenn.edu/~bcpierce/unison/"
  url "https://github.com/bcpierce00/unison/archive/v2.48.15v4.tar.gz"
  sha256 "f8c7e982634bbe1ed6510fe5b36b6c5c55c06caefddafdd9edc08812305fdeec"
  license "GPL-3.0-or-later"
  head "https://github.com/bcpierce00/unison.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, high_sierra: "eb01217a48646b393a4769bdc25e1e947667816a38de9003211ac0342b8ec611"
    sha256 cellar: :any_skip_relocation, sierra:      "f9a68dceab3225aecf77c698a6db9f6aacd4f3795a63c2abc4c4cffdb0a13af5"
    sha256 cellar: :any_skip_relocation, el_capitan:  "74a22e776363cdc5a6d849c77e92d08747cc97b8f48a579ccae909eb8eccdcfc"
  end

  depends_on "ocaml" => :build

  def install
    ENV.deparallelize
    ENV.delete "CFLAGS" # ocamlopt reads CFLAGS but doesn't understand common options
    ENV.delete "NAME" # https://github.com/Homebrew/homebrew/issues/28642
    system "make", "src/mkProjectInfo"
    system "make", "UISTYLE=text"
    bin.install "src/unison"
    prefix.install_metafiles "src"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/unison -version")
  end
end
