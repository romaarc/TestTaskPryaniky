//
//  Records.swift
//  TestTaskPryaniky
//
//  Created by Roman Gorshkov on 26.05.2022.
//

import Foundation

struct Records: Decodable {
    let text: String?
    let url: String?
    let selectedId: Int?
    let variants: [Variant]?
}

struct Variant: Decodable {
    let id: Int
    let text: String
}
