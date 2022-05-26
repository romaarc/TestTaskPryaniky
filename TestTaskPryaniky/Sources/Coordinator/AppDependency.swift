//
//  AppDependency.swift
//  TestTaskPryaniky
//
//  Created by Roman Gorshkov on 26.05.2022.
//

import Foundation

protocol HasDependencies {
    var pryanikNetworkService: NetworkServiceProtocol { get }
    var pryanikyViewModel: PryanikViewModelProtocol { get }
}

final class AppDependency {
    private let networkService: NetworkService
    private let pryanikViewModel: PryanikViewModel

    init(networkService: NetworkService,
         pryanikViewModel: PryanikViewModel) {
        self.networkService = networkService
        self.pryanikViewModel = pryanikViewModel
    }

    static func makeDefault() -> AppDependency {
        let networkService = NetworkService()
        let pryanikViewModel = PryanikViewModel(pryanikNetworkService: networkService)
        return AppDependency(networkService: networkService,
                             pryanikViewModel: pryanikViewModel)
    }
}

extension AppDependency: HasDependencies {
    var pryanikyViewModel: PryanikViewModelProtocol {
        self.pryanikViewModel
    }

    var pryanikNetworkService: NetworkServiceProtocol {
        return self.networkService
    }
}
