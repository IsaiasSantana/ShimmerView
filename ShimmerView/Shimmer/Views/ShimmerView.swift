import Foundation
import UIKit

final class ShimmerView: UIView {
    private enum ShimmerKeys: String {
        case shimmerKeyPath = "transform.translation.x"
        case shimmerKey
    }

    private let shimmerViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    private var gradientLayer = CAGradientLayer()

    private var configuration = ShimmerConfiguration()

    init(configuration: ShimmerConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }

    private func updateGradientFrame() {
        gradientLayer.frame = shimmerViewContainer.bounds
        stopShimmer()
        startShimmer()
    }

    func stopShimmer() {
        gradientLayer.removeAnimation(forKey: ShimmerKeys.shimmerKey.rawValue)
    }

    func startShimmer() {
        gradientLayer.add(buildAnimation(), forKey: ShimmerKeys.shimmerKey.rawValue)
    }

    private func buildAnimation() -> CAAnimation {
        let animation = CABasicAnimation(keyPath: ShimmerKeys.shimmerKeyPath.rawValue)

        animation.duration = configuration.animationDuration
        animation.repeatCount = configuration.repeatCount
        animation.fromValue = -shimmerViewContainer.bounds.width
        animation.toValue = shimmerViewContainer.bounds.width

        return animation
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        setupShimmerViewContainer()
        setupGradientLayer()
        startShimmer()
    }

    private func setupShimmerViewContainer() {
        addSubview(shimmerViewContainer)
        NSLayoutConstraint.activate([
            shimmerViewContainer.topAnchor.constraint(equalTo: topAnchor),
            shimmerViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            shimmerViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            shimmerViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        shimmerViewContainer.backgroundColor = configuration.tintColor
    }

    private func setupGradientLayer() {
        gradientLayer = buildGradient()
        gradientLayer.frame = shimmerViewContainer.bounds
        shimmerViewContainer.layer.addSublayer(gradientLayer)
    }

    private func buildGradient() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()

        gradientLayer.colors = [
            configuration.tintColor.cgColor,
            UIColor.white.cgColor,
            configuration.tintColor.cgColor
        ]

        gradientLayer.locations =  [0.0, 0.5, 1.0]

        let bottomLeftPoint = CGPoint(x: 0.0, y: 1.0)
        let bottomRightPoint = CGPoint(x: 1.0, y: 1.0)

        gradientLayer.startPoint = bottomLeftPoint
        gradientLayer.endPoint = bottomRightPoint

        return gradientLayer
    }
}
