//
//  Timeline.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 27/05/21.
//

import Foundation

class Timeline: Decodable {
    public var ano: Int = 0
    public var descricao: String = ""
    public var imagemWeb: String = ""
    public var imagemMobile: String = ""
    
    enum CodingKeys: String, CodingKey {
        case ano
        case descricao
        case imagemMobile
    }
}
