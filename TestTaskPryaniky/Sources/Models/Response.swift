//
//  Response.swift
//  TestTaskPryaniky
//
//  Created by Roman Gorshkov on 26.05.2022.
//

import Foundation

struct Response: Decodable {
    let data: [Meta]
    let view: [String]
}
