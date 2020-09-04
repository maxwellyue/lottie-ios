//
//  LottieView.swift
//  lottie-swift-iOS
//
//  Created by Brandon Withrow on 2/6/19.
//

import Foundation
#if canImport(UIKit)
    import UIKit

    open class LottieView: UIView {
        var viewLayer: CALayer? {
            return layer
        }

        func layoutAnimation() {
        }

        func animationMovedToWindow() {
        }

        override open func didMoveToWindow() {
            super.didMoveToWindow()
            animationMovedToWindow()
        }

        var screenScale: CGFloat {
            return UIScreen.main.scale
        }

        func commonInit() {
            contentMode = .scaleAspectFit
            clipsToBounds = true
            NotificationCenter.default.addObserver(self, selector: #selector(animationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(animationWillMoveToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        }

        override open var contentMode: UIView.ContentMode {
            didSet {
                setNeedsLayout()
            }
        }

        override open func layoutSubviews() {
            super.layoutSubviews()
            layoutAnimation()
        }

        @objc func animationWillMoveToBackground() {
        }

        @objc func animationWillEnterForeground() {
        }
    }

#endif

#if os(macOS)
    import AppKit

    public enum LottieContentMode: Int {
        case scaleToFill
        case scaleAspectFit
        case scaleAspectFill
        case redraw
        case center
        case top
        case bottom
        case left
        case right
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }

    /// A wrapper around NSView for cross platform compatibility.

    public class LottieView: NSView {
        var screenScale: CGFloat {
            return NSApp.mainWindow?.backingScaleFactor ?? 1
        }

        var viewLayer: CALayer? {
            return layer
        }

        func layoutAnimation() {
        }

        func animationMovedToWindow() {
        }

        override public func viewDidMoveToWindow() {
            super.viewDidMoveToWindow()
            animationMovedToWindow()
        }

        func commonInit() {
            wantsLayer = true
        }

        func setNeedsLayout() {
            needsLayout = true
        }

        func layoutIfNeeded() {
        }

        override public var wantsUpdateLayer: Bool {
            return true
        }

        override public var isFlipped: Bool {
            return true
        }

        public var contentMode: LottieContentMode = .scaleAspectFit {
            didSet {
                setNeedsLayout()
            }
        }

        override public func layout() {
            super.layout()
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            layoutAnimation()
            CATransaction.commit()
        }

        @objc func animationWillMoveToBackground() {
        }

        @objc func animationWillEnterForeground() {
        }
    }
#endif

// public typealias LottieView = UIView
