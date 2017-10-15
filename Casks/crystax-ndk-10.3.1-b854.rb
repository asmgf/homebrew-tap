cask 'crystax-ndk-10.3.1-b854' do
  version '10.3.1-b854'
  sha256 '21a644b208550dde6ae93ba32f7e27b24d622c871236693c5ad498deb599ab03'

  url "https://dl.crystax.net/builds/854/darwin/crystax-ndk-10.3.1-b854-darwin-x86_64.tar.xz"
  name 'Crystax NDK'
  homepage 'https://www.crystax.net/android/ndk'

  preflight do
    FileUtils.ln_sf("#{staged_path}/crystax-ndk-10.3.1", "#{HOMEBREW_PREFIX}/share/crystax-ndk")
  end

  uninstall_postflight do
    FileUtils.rm("#{HOMEBREW_PREFIX}/share/crystax-ndk")
  end

  caveats <<-EOS.undent
   You may want to add to your profile:
      'export ANDROID_NDK_HOME="#{HOMEBREW_PREFIX}/share/crystax-ndk"'
  EOS
end
