import Foundation
import UIKit

extension UIView {
    func showShimmer(configuration: ShimmerConfiguration = .init()) {
        let shimmerViewContainer = ShimmerViewContainer(configuration: configuration)
        addSubview(shimmerViewContainer)
        NSLayoutConstraint.activate([
            shimmerViewContainer.topAnchor.constraint(equalTo: topAnchor),
            shimmerViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            shimmerViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            shimmerViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        shimmerViewContainer.startShimmer()
    }

    func removeShimmer() {
        for subview in subviews where subview is ShimmerViewContainer {
            subview.removeShimmer()
            subview.removeFromSuperview()
        }
    }
}
