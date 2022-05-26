//
//  PryanikDetailView.swift
//  TestTaskPryaniky
//
//  Created by Roman Gorshkov on 27.05.2022.
//

import UIKit

extension PryanikDetailView {
    struct Appearance {
        let backgroundColor = UIColor.white
    }
}

final class PryanikDetailView: UIView {
    let appearance: Appearance
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.font = Font.sber(ofSize: Font.Size.thirdyFour, weight: .regular)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: 0.07, .paragraphStyle: paragraphStyle])
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    init(
        frame: CGRect = .zero,
        appearance: Appearance = Appearance()
    ) {
        self.appearance = appearance
        super.init(frame: frame)
        
        self.setupView()
        self.addSubviews()
        self.makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PryanikDetailView: ProgrammaticallyInitializableViewProtocol {
    func setupView() {
        backgroundColor = appearance.backgroundColor
    }
    
    func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        [label, imageView].forEach { contentView.addSubview($0) }
    }
    
    func makeConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor,
                constant:  -UIScreen.main.bounds.height / 2.2
            ),
            
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -70),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).priority = .defaultLow
    }
    
    func update(with viewModel: Meta, and variant: String? = nil) {
        
        if let variant = variant {
            label.text = "\(viewModel.name) \(variant)"
        } else {
            label.text = viewModel.name
        }
        
        if let url = viewModel.data.url {
            imageView.setImage(with: URL(string: url), id: viewModel.name)
        }
    }
}
