//
//  BorderView.swift
//  ZRPostCells
//
//  Created by Anthony Miller on 10/9/15.
//  Copyright © 2015 App-Order. All rights reserved.
//

import UIKit

public enum EdgePosition {
  case Top,
  Right,
  Bottom,
  Left
  
  private func horizontalConstraintFormat(viewName: String, leadingSpace: CGFloat, trailingSpace: CGFloat) -> String {
    switch self {
    case Top, Bottom: return "H:|-(\(leadingSpace))-[\(viewName)]-(\(trailingSpace))-|"
    case Right: return "H:[\(viewName)]|"
    case Left: return "H:|[\(viewName)]"
    }
  }
  
  private func verticalConstraintFormat(viewName: String, leadingSpace: CGFloat, trailingSpace: CGFloat) -> String {
    switch self {
    case Right, Left: return "V:|-(\(leadingSpace))-[\(viewName)]-(\(trailingSpace))-|"
    case Top: return "V:|[\(viewName)]"
    case Bottom: return "V:[\(viewName)]|"
    }
  }
  
  private var widthLayoutAttribute: NSLayoutAttribute {
    switch self {
    case Right, Left: return .Width
    case Top, Bottom: return .Height
    }
  }
}

/// A `UIView` subclass that can be used as a border added to another view on one edge.
public class EdgeView: UIView {
  
  /*
  *  MARK: - Class Methods
  */
  
  /**
  Adds a `BorderView` to the given view on the given edge
  
  - parameter view:  The view to add the border to
  - parameter edge:  The edge of the view to add the border to
  - parameter width: The width of the border to add to the view, defaults to `1.0`
  - parameter color: The color of the border to add to the view, defaults to `UIColor.blackColor()`
  
  - returns: The `BorderView` that was added to the view
  */
  public class func addEdgeToView(view: UIView,
    position: EdgePosition,
    width: CGFloat = 1.0,
    color: UIColor = UIColor.blackColor(),
    leadingSpace: CGFloat = 0.0,
    trailingSpace: CGFloat = 0.0) -> EdgeView {
      let border = EdgeView(position: position)
      border.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(border)
      
      let borderName = "border"
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(position.horizontalConstraintFormat(borderName, leadingSpace: leadingSpace, trailingSpace: trailingSpace),
        options: NSLayoutFormatOptions(rawValue: 0),
        metrics: nil,
        views: [borderName: border]))
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(position.verticalConstraintFormat(borderName, leadingSpace: leadingSpace, trailingSpace: trailingSpace),
        options: NSLayoutFormatOptions(rawValue: 0),
        metrics: nil,
        views: [borderName: border]))
      
      border.borderWidth = width
      border.borderColor = color
      
      return border
  }
  
  /*
  *  MARK: - Instance Properties
  */
  
  /// The color of the border. Defaults to `UIColor.blackColor()`
  public var borderColor: UIColor = UIColor.blackColor() {
    didSet {
      backgroundColor = borderColor
    }
  }
  
  /// The width of the border. Defaults to `1.0`
  public var borderWidth: CGFloat = 1.0 {
    didSet {
      borderWidthConstraint.constant = borderWidth
    }
  }
  
  private var borderWidthConstraint: NSLayoutConstraint!
  
  private let edgePosition: EdgePosition
  
  /*
  *  MARK: - Object Lifecycle
  */
  
  private convenience init(position: EdgePosition) {
    self.init(frame: CGRectZero, position: position)
  }
  
  private init(frame: CGRect, position: EdgePosition) {
    self.edgePosition = position
    
    super.init(frame: frame)
    
    setUpBorderWidthConstraint()
  }
  
  private func setUpBorderWidthConstraint() {
    borderWidthConstraint = NSLayoutConstraint(item: self,
      attribute: edgePosition.widthLayoutAttribute,
      relatedBy: .Equal,
      toItem: nil,
      attribute: .NotAnAttribute,
      multiplier: 0,
      constant: self.borderWidth)
    self.addConstraint(borderWidthConstraint)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    self.edgePosition = .Bottom
    
    super.init(coder: aDecoder)
    
    setUpBorderWidthConstraint()
  }
  
}

extension UIView {
  
  public func AM_addEdge(position: EdgePosition,
    width: CGFloat = 1.0,
    color: UIColor = UIColor.blackColor(),
    leadingSpace: CGFloat = 0.0,
    trailingSpace: CGFloat = 0.0) -> EdgeView {
      return EdgeView.addEdgeToView(self,
        position: position,
        width: width,
        color: color,
        leadingSpace: leadingSpace,
        trailingSpace: trailingSpace)
  }
  
}