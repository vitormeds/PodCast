//
//  IAProducts.swift
//  PodCast
//
//  Created by Vitor on 31/01/20.
//  Copyright © 2020 Vitor Mendes. All rights reserved.
//

import Foundation

public struct IAProducts {
    
    public static let premium: ProductIdentifier = "Premium"
    
    fileprivate static let productIdentifiers: Set<ProductIdentifier> = [IAProducts.premium]
    
    public static let store = IAPHelper(productIds: IAProducts.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
    return productIdentifier.components(separatedBy: ".").last
}
