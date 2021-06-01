//
//  Product.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import Foundation

struct Product: Decodable {
    public var id: String = ""
    public var imagem: String = ""
    public var nome: String = ""
    public var descricao: String = ""
    public var tipo: String = ""
    public var link: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case imagem
        case nome
        case descricao
        case tipo
        case link
    }
}
