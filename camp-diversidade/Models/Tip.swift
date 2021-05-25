//
//  Tip.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import Foundation

struct Tip: Decodable {
    var id: String = ""
    var imagem: String = ""
    var titulo: String = ""
    var descricao: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case imagem
        case titulo
        case descricao
    }
}
