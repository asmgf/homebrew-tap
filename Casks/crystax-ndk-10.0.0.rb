cask 'crystax-ndk-10.0.0' do
  version '10.0.0'
  sha256 'e65d117e41ec51f55728a3880d4a97d7deb4f807d55c4391def119379b6edf23'

  url "https://www.crystax.net/download/crystax-ndk-#{version}-darwin-x86_64.tar.bz2"
  name 'Crystax NDK'
  homepage 'https://www.crystax.net/android/ndk'

  conflicts_with cask: 'android-ndk'

  # shim script (https://github.com/caskroom/homebrew-cask/issues/18809)
  shimscript = "#{staged_path}/ndk_exec.sh"
  preflight do
    FileUtils.ln_sf("#{staged_path}/crystax-ndk-#{version}", "#{HOMEBREW_PREFIX}/share/crystax-ndk")

    IO.write shimscript, <<-EOS.undent
      #!/bin/bash
      readonly executable="#{staged_path}/crystax-ndk-#{version}/$(basename ${0})"
      test -f "${executable}" && exec "${executable}" "${@}"
    EOS
  end

  [
    'ndk-build',
    'ndk-depends',
    'ndk-gdb',
    'ndk-stack',
    'ndk-which',
  ].each { |link_name| binary shimscript, target: link_name }

  uninstall_postflight do
    FileUtils.rm("#{HOMEBREW_PREFIX}/share/crystax-ndk")
  end

  caveats <<-EOS.undent
   You may want to add to your profile:
      'export ANDROID_NDK_HOME="#{HOMEBREW_PREFIX}/share/crystax-ndk"'
  EOS
end
