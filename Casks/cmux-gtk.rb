cask "cmux-gtk" do
  version "0.6.17"
  sha256 "590a2a6cf2a86a447c4de71dda7e35038d07bcf5cb86eed30701a8bce0cdba7e"

  url "https://github.com/nitecon/cmux-gtk/releases/download/v#{version}/cmux-gtk-linux-x86_64.tar.gz"
  name "cmux GTK"
  desc "GPU-accelerated terminal multiplexer powered by Ghostty"
  homepage "https://github.com/nitecon/cmux-gtk"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :x86_64
  depends_on formula: %w[
    fontconfig
    freetype
    gtk4
    llvm
    libnotify
    oniguruma
  ]
  depends_on :linux

  command_wrapper "cmux",
                  content: <<~SH
                    #!/bin/sh
                    exec "#{staged_path}/cmux" "$@"
                  SH
  command_wrapper "cmux-app",
                  content: <<~SH
                    #!/bin/sh
                    app="#{staged_path}/cmux-app"
                    if ldd "$app" 2>/dev/null | grep -q "not found"; then
                      export LD_LIBRARY_PATH="#{HOMEBREW_PREFIX}/opt/llvm/lib:#{HOMEBREW_PREFIX}/opt/gtk4/lib:#{HOMEBREW_PREFIX}/opt/fontconfig/lib:#{HOMEBREW_PREFIX}/opt/freetype/lib:#{HOMEBREW_PREFIX}/opt/oniguruma/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
                    fi
                    exec "$app" "$@"
                  SH
  artifact "share/applications/io.cmux.App.desktop",
           target: "#{Dir.home}/.local/share/applications/io.cmux.App.desktop"
  artifact "share/icons/hicolor/48x48/apps/io.cmux.App.png",
           target: "#{Dir.home}/.local/share/icons/hicolor/48x48/apps/io.cmux.App.png"
  artifact "share/icons/hicolor/128x128/apps/io.cmux.App.png",
           target: "#{Dir.home}/.local/share/icons/hicolor/128x128/apps/io.cmux.App.png"
  artifact "share/icons/hicolor/256x256/apps/io.cmux.App.png",
           target: "#{Dir.home}/.local/share/icons/hicolor/256x256/apps/io.cmux.App.png"

  preflight_steps do
    inreplace "share/applications/io.cmux.App.desktop", /^Exec=cmux-app$/, "Exec={{HOMEBREW_PREFIX}}/bin/cmux-app"
  end
end
