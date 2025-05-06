class Kodit < Formula
    include Language::Python::Virtualenv
  
    desc "Kodit is an MCP server that indexes your private codebases"
    homepage "https://docs.helixml.tech/kodit/"
    url "https://pypi.io/packages/source/k/kodit/kodit-0.1.0.tar.gz"
    sha256 "3ade4167c68d921b3b329e4ad08c4828313b78bfef7b5e81b54f8680a0508d0f"
    license "Apache-2.0"
  
    depends_on "python@3.12"
    depends_on "uv"
  
    def install
      ENV["VIRTUAL_ENV"] = libexec
      system "uv", "venv", libexec
      ENV.prepend_path "PATH", "#{libexec}/bin"
      system "uv", "pip", "install", buildpath
      system "uv", "pip", "install", *resource_files if resources.any?
      
      bin.install Dir[libexec/"bin/*"]
      bin.env_script_all_files(libexec/"bin", PYTHONPATH: ENV["PYTHONPATH"])
    end
  
    test do
      assert_match "Usage: kodit [OPTIONS] COMMAND [ARGS]...", shell_output("#{bin}/kodit --help")
    end
  end
  