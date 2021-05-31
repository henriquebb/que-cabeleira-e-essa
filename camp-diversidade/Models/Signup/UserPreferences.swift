//
//  UserPreferences.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import Foundation

struct UserPreferences: Codable {
    
    public var curvaturaCabelo: Int = 0
    public var situacaoCabelo: Int = 0
    public var temAlisamento: Bool = false
    public var temTintura: Bool = false
    public var temDescoloracao: Bool = false
    public var temCaspa: Bool = false
    public var temQueda: Bool = false
    public var temFiosElasticos: Bool = false
    public var produtoEhVegano: Bool = false
    public var produtoEhCrueltyfree: Bool = false
    public var produtoEhNoPooLowPoo: Bool = false
    public var produtoSemParabenos: Bool = false
    public var produtoEhNatural: Bool = false
    public var produtoDahBrilho: Bool = false
    public var produtoDahMaciezHidratacao: Bool = false
    public var produtoDahDefinicao: Bool = false
    public var produtoDahCrescimento: Bool = false
    public var produtoDahVolume: Bool = false
    public var produtoControlaOleosidade: Bool = false
    public var produtoControlaVolume: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case curvaturaCabelo = "curvaturaCabelo"
        case situacaoCabelo
        case temAlisamento
        case temTintura
        case temDescoloracao
        case temCaspa
        case temQueda
        case temFiosElasticos
        case produtoEhVegano
        case produtoEhCrueltyfree
        case produtoEhNoPooLowPoo
        case produtoSemParabenos
        case produtoEhNatural
        case produtoDahBrilho
        case produtoDahMaciezHidratacao
        case produtoDahDefinicao
        case produtoDahCrescimento
        case produtoDahVolume
        case produtoControlaOleosidade
        case produtoControlaVolume
    }
}
