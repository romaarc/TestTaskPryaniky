//
//  PryanikDetailViewController.swift
//  TestTaskPryaniky
//
//  Created by Roman Gorshkov on 27.05.2022.
//

import UIKit

final class PryanikDetailViewController: BaseViewController {
    private var viewModel: PryanikDetailViewModelProtocol
    
    private var pryanikDetailView: PryanikDetailView { self.view as! PryanikDetailView }
    
    init(viewModel: PryanikDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        let view = PryanikDetailView(frame: UIScreen.main.bounds)
        self.view = view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        updateUI(with: viewModel.data)
    }
    
    private func setupNavBar() {
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .white
        title = viewModel.data.name
    }
}

extension PryanikDetailViewController {
    private func updateUI(with viewModel: Meta) {
        pryanikDetailView.update(with: viewModel, and: self.viewModel.variant?.text)
    }
}
