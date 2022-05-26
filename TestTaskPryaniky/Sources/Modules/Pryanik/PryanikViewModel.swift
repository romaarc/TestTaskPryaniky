//
//  PryanikViewModel.swift
//  TestTaskPryaniky
//
//  Created by Roman Gorshkov on 26.05.2022.
//

import Foundation
import RxSwift
import RxCocoa
import Action

protocol PryanikViewModelInputs {
    var fetchTrigger: PublishSubject<Void> { get }
}

protocol PryanikViewModelOutputs {
    var data: Observable<[Meta]> { get }
    var isLoading: Observable<Bool> { get }
    var error: Observable<Error> { get }
}

protocol PryanikViewModelType {
    var inputs: PryanikViewModelInputs { get }
    var outputs: PryanikViewModelOutputs { get }
}

protocol PryanikViewModelProtocol: PryanikViewModelType & PryanikViewModelInputs &  PryanikViewModelOutputs {}

final class PryanikViewModel: PryanikViewModelProtocol {
    var inputs: PryanikViewModelInputs { self }
    var outputs: PryanikViewModelOutputs { self }
    
    // MARK: - Inputs
    let fetchTrigger = PublishSubject<Void>()
    // MARK: - Outputs
    var data: Observable<[Meta]>
    var isLoading: Observable<Bool>
    var error: Observable<Error>
    
    private let disposeBag = DisposeBag()
    private let fetchAction: Action<Bool, [Response]>
    private let pryanikNetworkService: NetworkServiceProtocol
    private let start = BehaviorRelay<Bool>(value: false)
    
    init(pryanikNetworkService: NetworkServiceProtocol) {
        
        self.pryanikNetworkService = pryanikNetworkService
        
        self.fetchAction = Action { _ in
            return pryanikNetworkService.fetch()
        }
            
        let response = BehaviorRelay<[Meta]>(value: [])
        self.data = response.asObservable()
        self.isLoading = fetchAction.executing.startWith(false)
        self.error = fetchAction.errors.map { _ in NSError(domain: "Error", code: 0, userInfo: nil) }
        
        fetchAction.elements
                    .withLatestFrom(response) { ($0, $1) }
                    .map {
                        let views = $0.0[0].view
                        let metas = $0.0[0].data
                        var dict = [String: Meta]()
                        metas.forEach { dict[$0.name] = $0 }
                        return views.compactMap { dict[$0] }
                    }
                    .bind(to: response)
                    .disposed(by: disposeBag)
        
        fetchTrigger
                    .withLatestFrom(start)
                    .bind(to: fetchAction.inputs)
                    .disposed(by: disposeBag)
    }
}
