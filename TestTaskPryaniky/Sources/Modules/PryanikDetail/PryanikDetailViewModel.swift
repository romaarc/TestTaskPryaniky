//
//  PryanikDetailViewModel.swift
//  TestTaskPryaniky
//
//  Created by Roman Gorshkov on 27.05.2022.
//

import Foundation

protocol PryanikDetailViewModelProtocol {
    var data: Meta { get set }
    var variant: Variant? { get }
}

final class PryanikDetailViewModel: PryanikDetailViewModelProtocol {
    var data: Meta
    let variant: Variant?
    
    init(
        data: Meta,
        variant: Variant? = nil
    ) {
        self.data = data
        self.variant = variant
    }
}
