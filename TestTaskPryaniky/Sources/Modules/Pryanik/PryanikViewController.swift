//
//  PryanikViewController.swift
//  TestTaskPryaniky
//
//  Created by Roman Gorshkov on 26.05.2022.
//

import Foundation
import RxSwift
import RxCocoa

final class PryanikViewController: BaseViewController {
    private var viewModel: PryanikViewModelProtocol
    private var pryanikView: PryanikView { self.view as! PryanikView }
    
    init(viewModel: PryanikViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = PryanikView(frame: UIScreen.main.bounds)
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.outputs.data
            .observe(on: MainScheduler.instance)
            .bind(to: pryanikView.collectionView.rx.items) { [weak self] collectionView, row, response in
                guard let self = self else { return UICollectionViewCell() }
                let cell = self.pryanikView.collectionView.dequeueCell(
                    cellType: PryanikCell.self,
                    for: IndexPath(row: row, section: 0)
                )
                cell.update(with: response)
                return cell
            }.disposed(by: disposeBag)
        
        pryanikView.collectionView.rx.itemHighlighted
            .subscribe(onNext: { [weak self] indexPath in
                if let cell = self?.pryanikView.collectionView.cellForItem(at: indexPath) {
                    UIView.animate(withDuration: 1, delay: .zero, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut) {
                        cell.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
                    }
                }
            }).disposed(by: disposeBag)
        
        pryanikView.collectionView.rx.itemUnhighlighted
            .subscribe(onNext: { [weak self] indexPath in
                if let cell = self?.pryanikView.collectionView.cellForItem(at: indexPath) {
                    UIView.animate(withDuration: 0.7, delay: .zero, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseIn) {
                        cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                    }
                }
            }).disposed(by: disposeBag)
        
        viewModel.outputs.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        viewModel.outputs.isLoading
            .observe(on: MainScheduler.instance)
            .bind(to: pryanikView.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.inputs.fetchTrigger.onNext(())
        
        pryanikView.collectionView.rx.modelSelected(Meta.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if let _ = $0.data.url {
                    let detailViewModel = PryanikDetailViewModel(data: $0)
                    let pryanikDetailVC = PryanikDetailViewController(viewModel: detailViewModel)
                    pryanikDetailVC.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(pryanikDetailVC, animated: true)
                } else if let vars = $0.data.variants {
                    let alert = self.showAlertController(with: vars, and: $0)
                    self.present(alert, animated: true)
                } else {
                    let detailViewModel = PryanikDetailViewModel(data: $0)
                    let pryanikDetailVC = PryanikDetailViewController(viewModel: detailViewModel)
                    pryanikDetailVC.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(pryanikDetailVC, animated: true)
                }
              
            })
            .disposed(by: disposeBag)
    }
    
    private func showAlertController(with variants: [Variant], and meta: Meta) -> UIAlertController {
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel
        )
        let alertController = UIAlertController(
            title: "Choose selector",
            message: nil,
            preferredStyle: .actionSheet
        )
        for variant in variants {
            alertController.addAction(UIAlertAction(title: String(variant.id), style: .default, handler: { [weak self] _ in
                let detailViewModel = PryanikDetailViewModel(data: meta, variant: variant)
                let pryanikDetailVC = PryanikDetailViewController(viewModel: detailViewModel)
                pryanikDetailVC.modalPresentationStyle = .fullScreen
                self?.navigationController?.pushViewController(pryanikDetailVC, animated: true)
            }))
        }
        alertController.addAction(cancelAction)
        return alertController
    }
}
