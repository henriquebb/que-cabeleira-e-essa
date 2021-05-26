//
//  Product.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import Foundation

struct Product: Decodable {
    var id: String = ""
    var imagem: String = ""
    var nome: String = ""
    var descricao: String = ""
    var tipo: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case imagem
        case nome
        case descricao
        case tipo
    }
}
