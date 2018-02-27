cask 'android-ndk-keg-10e' do
  version '10e'
  sha256 'e205278fba12188c02037bfe3088eba34d8b5d96b1e71c8405f9e6e155a3bce4'

  url "https://dl.google.com/android/repository/android-ndk-r#{version}-darwin-x86_64.zip"
  name 'Android NDK'
  homepage 'https://developer.android.com/ndk/index.html'

  preflight do
    FileUtils.ln_sf("#{staged_path}/android-ndk-r#{version}", "#{HOMEBREW_PREFIX}/share/android-ndk")
  end

  uninstall_postflight do
    FileUtils.rm("#{HOMEBREW_PREFIX}/share/android-ndk")
  end
end
