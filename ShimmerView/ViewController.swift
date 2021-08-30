import UIKit

final class ViewController: UIViewController {
    private let contentView = ExampleView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        title = "Shimmer View"

        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: Sample Views

final class ExampleView: UIView, UITableViewDelegate, UITableViewDataSource {
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private let headerView = HeaderView(frame: .zero)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.description())
        tableView.register(HeaderViewCell.self, forCellReuseIdentifier: HeaderViewCell.description())
        return tableView
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        setupContentView()
    }

    private func setupContentView() {
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        setupHeaderView()
        setupTableView()
    }

    private func setupHeaderView() {
        contentView.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 16),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        headerView.startLoading()
    }

    private func setupTableView() {
        contentView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 25),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 5  {
            if let cell = tableView.dequeueReusableCell(withIdentifier: HeaderViewCell.description()) as? HeaderViewCell {
                return cell
            } else {
                return UITableViewCell()
            }
        }
        return tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.description()) as? CustomTableViewCell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
}

// MARK: Header View

final class HeaderView: UIView {
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()

    private let icon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        return image
    }()
    
    private let labelsStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 8
        return stackview
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        label.numberOfLines = 2
        label.text = " "
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        setupContentStackView()
    }

    private func setupContentStackView() {
        addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        setupIcon()
        setupLabelsStack()
    }

    private func setupIcon() {
        contentStackView.addArrangedSubview(icon)
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 100),
        ])
       let constraint = icon.heightAnchor.constraint(equalToConstant: 100)
        constraint.priority = .init(250)
        constraint.isActive = true
    }

    private func setupLabelsStack() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(labelsStackView)

        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            labelsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
        ])

        contentStackView.addArrangedSubview(containerView)

        setupTitle()
        setupDescription()
    }

    private func setupTitle() {
        labelsStackView.addArrangedSubview(titleLabel)
    }

    private func setupDescription() {
        labelsStackView.addArrangedSubview(descriptionLabel)
    }

    func startLoading() {
        icon.showShimmer()
        titleLabel.showShimmer()
        descriptionLabel.showShimmer()
    }
}

// MARK: HeaderViewCell

final class HeaderViewCell: UITableViewCell {
    private let headerView = HeaderView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        headerView.startLoading()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: CustomTableViewCell
final class CustomTableViewCell: UITableViewCell {
    private let customContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(customContentView)
        NSLayoutConstraint.activate([
            customContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        let color = UIColor(red: CGFloat.random(in: 0.0...1.0),
                            green: CGFloat.random(in: 0.0...1.0),
                            blue: CGFloat.random(in: 0.0...1.0),
                            alpha: 1)

        customContentView.showShimmer(configuration: .init(tintColor: color))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
