//
//  Results.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 27/05/21.
//

import Foundation

class Results: Decodable {
    public var id: String = ""
    public var texto: Result
    
    enum CodingKeys: String, CodingKey {
        case id
        case texto
    }
}
