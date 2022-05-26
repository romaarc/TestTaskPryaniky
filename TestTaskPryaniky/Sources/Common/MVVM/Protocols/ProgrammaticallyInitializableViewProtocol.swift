//
//  ProgrammaticallyInitializableViewProtocol.swift
//  TestTaskPryaniky
//
//  Created by Roman Gorshkov on 26.05.2022.
//

import UIKit

protocol ProgrammaticallyInitializableViewProtocol: AnyObject {
    func setupView()
    func addSubviews()
    func makeConstraints()
}

extension ProgrammaticallyInitializableViewProtocol where Self: UIView {
    func setupView() {}
    func addSubviews() {}
    func makeConstraints() {}
}
