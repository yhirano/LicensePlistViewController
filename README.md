LicensePlistDetailViewController
==

![platforms](https://img.shields.io/badge/platforms-iOS-333333.svg)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/mono0926/NativePopup/master/LICENSE)
[![Language: Swift 4.0](https://img.shields.io/badge/swift-4.0-4BC51D.svg?style=flat)](https://developer.apple.com/swift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/hsylife/SwiftyPickerPopover)

LicensePlistDetailViewController is ViewController for [LicensePlist](https://github.com/mono0926/LicensePlist/).

![Screen shot](doc/screenshot1.png)
![Screen shot](doc/screenshot2.png)

## Installation

### Cartage

Simply add the following line to your `Cartfile`:

```
github "yhirano/LicensePlistDetailViewController"
```

## Usage

### Install LicensePlist

[Install LicensePlist](https://github.com/mono0926/LicensePlist/#installation).

Example Homebrew:

```
brew install mono0926/license-plist/license-plist
```

### Use license-plist

[Use license-plist](https://github.com/mono0926/LicensePlist/#usage).

Example command:

On the directory same as `Cartfile` or `Pods`, simply execute `license-plist`.

```
license-plist
```

`com.mono0926.LicensePlist.Output` directory will be generated.

### Add refecense

Add reference `com.mono0926.LicensePlist.plist` file and `com.mono0926.LicensePlist` directory to source tree.

![XCode screen shot](doc/xcode.png)

### Call LicensePlistViewController

```swift
let viewController = LicensePlistViewController(fileNamed: "com.mono0926.LicensePlist")
self.navigationController?.pushViewController(viewController, animated: true)
```

## References

* [LicensePlist](https://github.com/mono0926/LicensePlist/)
* [AcknowList](https://github.com/vtourraine/AcknowList)
