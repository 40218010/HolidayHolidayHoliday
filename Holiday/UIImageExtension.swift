//
//  UIImage Extension.swift
//  Holiday
//
//  Created by 林大屍 on 2022/6/22.
//

import UIKit

extension UIImage {
    
    static func systemImage(name: String) -> UIImage? {
        let config1 = UIImage.SymbolConfiguration(hierarchicalColor: .systemMint)
        let config2 = UIImage.SymbolConfiguration(pointSize: 50, weight: .semibold, scale: .small)
        config1.applying(config2)
        return UIImage(systemName: name, withConfiguration: config1)
    }
    
}
