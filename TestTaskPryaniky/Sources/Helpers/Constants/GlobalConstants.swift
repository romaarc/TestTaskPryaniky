//
//  GlobalConstants.swift
//  TestTaskPryaniky
//
//  Created by Roman Gorshkov on 26.05.2022.
//

import UIKit

struct PryanikyConstants {
    struct Layout {
        static let cornerRadius: CGFloat = 8
        static let shadowRadius: CGFloat = 5
        static let shadowOpacity: Float = 0.1
        static let shadowOffsetWidth: CGFloat = 0
        static let shadowOffsetHeight: CGFloat = 5
    }
    
    struct Design {
        static var shadowColor = UIColor.black
    }
    
    struct Strings {
        static let emptyMessage = "Не найдено данных или подключитесь к сети, отключите VPN, чтобы загрузить данные.."
    }
}
