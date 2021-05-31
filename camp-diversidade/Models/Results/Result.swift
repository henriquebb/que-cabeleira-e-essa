//
//  Result.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 27/05/21.
//

import Foundation

class Result: Decodable {
    public var tipoCurvatura: String = ""
    public var situacaoCabelo: String = ""
    public var quimicaAlisamento: String = ""
    public var quimicaTintura: String = ""
    public var quimicaDescoloracao: String = ""
    public var patologiaCaspa: String = ""
    public var patologiaQueda: String = ""
    public var patologiaFiosElasticos: String = ""
    
    enum CodingKeys: String, CodingKey {
        case tipoCurvatura
        case situacaoCabelo
        case quimicaAlisamento
        case quimicaTintura
        case quimicaDescoloracao
        case patologiaCaspa
        case patologiaQueda
        case patologiaFiosElasticos
    }
}
