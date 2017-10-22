cask 'crystax-ndk-keg-10.3.2-b919' do
  version '10.3.2-b919'
  sha256 'abbc7109eff96c9a44933297ed4a90b52e8b07b1e392d51f35a013058a0a5fd0'

  url "https://dl.crystax.net/builds/#{version.match('\d+$')}/darwin/crystax-ndk-#{version}-darwin-x86_64.tar.xz"
  name 'Crystax NDK'
  homepage 'https://www.crystax.net/android/ndk'

  preflight do
    FileUtils.ln_sf("#{staged_path}/crystax-ndk-#{version.major_minor_patch}", "#{HOMEBREW_PREFIX}/share/crystax-ndk-keg-#{version}")
  end

  uninstall_postflight do
    FileUtils.rm("#{HOMEBREW_PREFIX}/share/crystax-ndk-keg-#{version}")
  end
end
