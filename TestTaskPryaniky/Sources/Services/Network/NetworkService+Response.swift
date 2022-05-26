//
//  NetworkService+Response.swift
//  TestTaskPryaniky
//
//  Created by Roman Gorshkov on 26.05.2022.
//

import Foundation
import RxSwift

extension NetworkService: NetworkServiceProtocol {
    func fetch() -> Observable<[Response]> {
        let request = URLFactory.getRequest()
        return self.baseRequest(request: request)
    }
}
