//
//  StackView.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 10/3/21.
//

import UIKit

extension UIStackView {
    func addBorder(color: UIColor, backgroundColor: UIColor, thickness: CGFloat) {
        let insetView = UIView(frame: bounds)
        insetView.backgroundColor = backgroundColor
        insetView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(insetView, at: 0)

        let borderBounds = CGRect(
            x: -thickness,
            y: -thickness,
            width: frame.size.width + thickness * 2,
            height: frame.size.height + thickness * 2)

        let borderView = UIView(frame: borderBounds)
        borderView.backgroundColor = color
        borderView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(borderView, at: 0)
    }
}
