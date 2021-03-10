//
//  CGFloat.swift
//  WonkaCrew
//
//  Created by Ángel Abad Pérez on 10/3/21.
//

import CoreGraphics

extension CGFloat {
    func percentage(from start: CGFloat, to end: CGFloat) -> CGFloat {
        if self < start {
            return .zero
        }
        
        if self > end {
            return 1.0
        }
        
        return (self - start) / (end - start)
    }
}
