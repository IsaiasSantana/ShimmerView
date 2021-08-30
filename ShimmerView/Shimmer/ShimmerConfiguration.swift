import Foundation
import UIKit

struct ShimmerConfiguration {
    let tintColor: UIColor
    let animationDuration: Double
    let repeatCount: Float

    init(tintColor: UIColor = .init(white: 0.87, alpha: 1.0),
         animationDuration: Double = 1.2,
         repeatCount: Float = .infinity) {
        self.tintColor = tintColor
        self.animationDuration = animationDuration
        self.repeatCount = repeatCount
    }
}
