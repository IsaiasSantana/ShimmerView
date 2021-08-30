import Foundation
import UIKit

protocol ShimmerViewContainerProtocol: AnyObject {
    init(frame: CGRect, configuration: ShimmerConfiguration)
    func startShimmer()
    func stopShimmer()
}

final class ShimmerViewContainer: UIView, ShimmerViewContainerProtocol {
    private let shimmerView: ShimmerView

    init(frame: CGRect = .zero, configuration: ShimmerConfiguration = .init()) {
        shimmerView = ShimmerView(configuration: configuration)
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        addSubview(shimmerView)
        NSLayoutConstraint.activate([
            shimmerView.topAnchor.constraint(equalTo: topAnchor),
            shimmerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shimmerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shimmerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        setupObservers()
    }

    private func setupObservers() {
        setupWillEnterForegroundNotification()
        setupWillEnterBackgroundNotification()
    }

    private func setupWillEnterForegroundNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willEnterForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }

    @objc private func willEnterForeground() {
        startShimmer()
    }

    private func setupWillEnterBackgroundNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willEnterBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
    }

    @objc private func willEnterBackground() {
        stopShimmer()
    }

    func startShimmer() {
        shimmerView.startShimmer()
    }

    func stopShimmer() {
        shimmerView.stopShimmer()
    }
}
