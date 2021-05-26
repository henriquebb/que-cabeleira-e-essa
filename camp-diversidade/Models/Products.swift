//
//  Products.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import Foundation

struct Products: Decodable {
    var metadata: ProductsMetadata
    var data: [Product] = []
    
    enum CodingKeys: String, CodingKey {
        case metadata
        case data
    }
}
