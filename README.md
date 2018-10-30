# ColorPickTip

[![CI Status](https://img.shields.io/travis/akeome/ColorPickTip.svg?style=flat)](https://travis-ci.org/akeome/ColorPickTip)
[![Version](https://img.shields.io/cocoapods/v/ColorPickTip.svg?style=flat)](https://cocoapods.org/pods/ColorPickTip)
[![License](https://img.shields.io/cocoapods/l/ColorPickTip.svg?style=flat)](https://cocoapods.org/pods/ColorPickTip)
[![Platform](https://img.shields.io/cocoapods/p/ColorPickTip.svg?style=flat)](https://cocoapods.org/pods/ColorPickTip)

## Overview

- Simple color-picker for iOS.
- Picked color is detected in closure.
- Customizable palette using UIColor.

## Demo

![oct-30-2018 21-16-30](https://user-images.githubusercontent.com/20479956/47717548-651f9900-dc89-11e8-8372-0dcee16b8fbd.gif)
![oct-30-2018 21-18-10](https://user-images.githubusercontent.com/20479956/47717564-71a3f180-dc89-11e8-88a3-dde17e4f01e4.gif)

## Requirements

- Xcode10
- Swift 4.2
- iOS 9.3 or higher

## Installation

ColorPickTip is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ColorPickTip'
```

## Usage

ColorPickTip is based on UIPopoverPresentationController.
To show it, use `present(_:animated:completion:)` method.

```swift
let paletteColors: [[UIColor?]] = [[.red, .green, .blue], [.white, nil, .black]]

let colorPickTipVC = ColorPickTipController(palette: paletteColors, options: nil)
colorPickTipVC.popoverPresentationController?.delegate = colorPickTipVC
colorPickTipVC.popoverPresentationController?.barButtonItem = sender // some UIButton
        
self.present(colorPickTipVC, animated: true, completion: nil)
```

## Options

There are some options.

```swift
/// Theme color of PopupView. Default is light.
public var popoverViewTheme: PopoverViewTheme

/// Style for color palette. Default is round.
public var paletteStyle: PaletteStyle

/// Dismiss popover after picked. Default is true.
public var isDismissOnPick: Bool

/// ViewSize. Default is width:240 / height:150.
public var viewSize: CGSize
```


## Author

[Twitter](https://twitter.com/akeome)

## License

ColorPickTip is available under the MIT license. See the LICENSE file for more info.
