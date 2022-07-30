//
//  PryanikCell.swift
//  TestTaskPryaniky
//
//  Created by Roman Gorshkov on 26.05.2022.
//

import UIKit

final class PryanikCell: BaseUICollectionViewCell {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.font = Font.sber(ofSize: Font.Size.thirdyFour, weight: .bold)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.89
        
        label.attributedText = NSMutableAttributedString(string: "", attributes: [.kern: 0.07, .paragraphStyle: paragraphStyle])
        
        return label
    }()
    
    override func setup() {
        setupView()
        addSubviews()
        makeConstraints()
    }
}

extension PryanikCell: ProgrammaticallyInitializableViewProtocol {
    func setupView() {
        cornerRadius = PryanikyConstants.Layout.cornerRadius
        shadowRadius = PryanikyConstants.Layout.shadowRadius
        shadowOpacity = PryanikyConstants.Layout.shadowOpacity
    }
    
    func addSubviews() {
        contentView.addSubview(label)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func update(with viewModel: Meta) {
        label.text = viewModel.name
    }
}
