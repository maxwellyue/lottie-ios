//
//  AnimationSubview.swift
//  lottie-swift
//
//  Created by Brandon Withrow on 2/4/19.
//

import Foundation
#if canImport(UIKit)
    import UIKit
    public final class AnimationSubview: UIView {
        var viewLayer: CALayer? {
            return layer
        }
    }
#endif

#if os(macOS)
    import AppKit
    public final class AnimationSubview: NSView {
        var viewLayer: CALayer? {
            return layer
        }
    }

#endif
