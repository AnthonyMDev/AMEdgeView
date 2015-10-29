# AMEdgeView

[![Version](https://img.shields.io/cocoapods/v/AMEdgeView.svg?style=flat)](http://cocoapods.org/pods/AMEdgeView)
[![License](https://img.shields.io/cocoapods/l/AMEdgeView.svg?style=flat)](http://cocoapods.org/pods/AMEdgeView)
[![Platform](https://img.shields.io/cocoapods/p/AMEdgeView.svg?style=flat)](http://cocoapods.org/pods/AMEdgeView)

`AMEdgeView` is a `UIView` subclass that can be used as a border added to another view on one edge.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

AMEdgeView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AMEdgeView"
```

## Usage

```
view.AM_addEdge(.Bottom) // Adds a black bottom edge with a width of 1.0.

view.AM_addEdge(.Left, width: 2.0, color: UIColor.redColor()) // Adds a red left edge with a width of 2.0.

view.AM_addEdge(.Top, leadingSpace: 5.0) // Adds a top edge with a width 5.0 space to its left.

view.AM_addEdge(.Right, trailingSpace: 5.0) // Adds a right edge with 5.0 space below it.
```

## Author

Anthony Miller, AnthonyMDev@gmail.com

## License

AMEdgeView is available under the MIT license. See the LICENSE file for more info.
