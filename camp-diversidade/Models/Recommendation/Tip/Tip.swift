//
//  Tip.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import Foundation

struct Tip: Decodable {
    public var id: String = ""
    public var titulo: String = ""
    public var descricao: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case titulo
        case descricao
    }
}
