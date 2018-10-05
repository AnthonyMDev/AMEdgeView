//
//  BorderView.swift
//  ZRPostCells
//
//  Created by Anthony Miller on 10/9/15.
//  Copyright © 2015 App-Order. All rights reserved.
//

import UIKit

public enum EdgePosition {
    case top,
    right,
    bottom,
    left
    
    fileprivate func horizontalConstraintFormat(_ viewName: String,
                                                leadingSpace: CGFloat,
                                                trailingSpace: CGFloat) -> String {
        switch self {
        case .top, .bottom: return "H:|-(\(leadingSpace))-[\(viewName)]-(\(trailingSpace))-|"
        case .right: return "H:[\(viewName)]|"
        case .left: return "H:|[\(viewName)]"
        }
    }
    
    fileprivate func verticalConstraintFormat(_ viewName: String,
                                              leadingSpace: CGFloat,
                                              trailingSpace: CGFloat) -> String {
        switch self {
        case .right, .left: return "V:|-(\(leadingSpace))-[\(viewName)]-(\(trailingSpace))-|"
        case .top: return "V:|[\(viewName)]"
        case .bottom: return "V:[\(viewName)]|"
        }
    }
    
    fileprivate var widthLayoutAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .right, .left: return .width
        case .top, .bottom: return .height
        }
    }
}

/// A `UIView` subclass that can be used as a border added to another view on one edge.
open class EdgeView: UIView {
    
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
    open class func addEdgeToView(_ view: UIView,
                                  position: EdgePosition,
                                  width: CGFloat = 1.0,
                                  color: UIColor = UIColor.black,
                                  leadingSpace: CGFloat = 0.0,
                                  trailingSpace: CGFloat = 0.0) -> EdgeView {
        let border = EdgeView(position: position)
        border.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(border)
        
        let borderName = "border"
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: position.horizontalConstraintFormat(borderName, leadingSpace: leadingSpace, trailingSpace: trailingSpace),
            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics: nil,
            views: [borderName: border]))
        
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: position.verticalConstraintFormat(borderName, leadingSpace: leadingSpace, trailingSpace: trailingSpace),
            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
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
    open var borderColor: UIColor = UIColor.black {
        didSet {
            backgroundColor = borderColor
        }
    }
    
    /// The width of the border. Defaults to `1.0`
    open var borderWidth: CGFloat = 1.0 {
        didSet {
            borderWidthConstraint.constant = borderWidth
        }
    }
    
    fileprivate var borderWidthConstraint: NSLayoutConstraint!
    
    fileprivate let edgePosition: EdgePosition
    
    /*
     *  MARK: - Object Lifecycle
     */
    
    fileprivate convenience init(position: EdgePosition) {
        self.init(frame: CGRect.zero, position: position)
    }
    
    fileprivate init(frame: CGRect, position: EdgePosition) {
        self.edgePosition = position
        
        super.init(frame: frame)
        
        setUpBorderWidthConstraint()
    }
    
    fileprivate func setUpBorderWidthConstraint() {
        borderWidthConstraint = NSLayoutConstraint(item: self,
                                                   attribute: edgePosition.widthLayoutAttribute,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 0,
                                                   constant: self.borderWidth)
        self.addConstraint(borderWidthConstraint)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.edgePosition = .bottom
        
        super.init(coder: aDecoder)
        
        setUpBorderWidthConstraint()
    }
    
}

extension UIView {
    
    @discardableResult
    public func AM_addEdge(_ position: EdgePosition,
                           width: CGFloat = 1.0,
                           color: UIColor = UIColor.black,
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
