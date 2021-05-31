//
//  Products.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import Foundation

struct Products: Decodable {
    public var metadata: ProductsMetadata
    public var data: [Product] = []
    
    enum CodingKeys: String, CodingKey {
        case metadata
        case data
    }
}
