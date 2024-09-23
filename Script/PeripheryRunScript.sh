if [[ "$(uname -m)" == arm64 ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if which periphery > /dev/null; then
    cd ../../
    pwd
    periphery scan --workspace ./Seugi.xcworkspace --schemes Seugi-iOS --targets Seugi-iOS DIContainer Feature Component Core Network Local --format xcode --report-exclude **/Derived/*.swift
    # Domain is not included

else
  echo "warning: Periphery not installed, download from https://github.com/peripheryapp/periphery"
fi
