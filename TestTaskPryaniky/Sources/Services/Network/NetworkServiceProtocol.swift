//
//  NetworkServiceProtocol.swift
//  TestTaskPryaniky
//
//  Created by Roman Gorshkov on 26.05.2022.
//

import Foundation
import RxSwift

protocol NetworkServiceProtocol {
    func fetch() -> Observable<[Response]>
}

