//
//  UserPreferences.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import Foundation

struct UserPreferences: Codable {
    var curvaturaCabelo: Int = 0
    var situacaoCabelo: Int = 0
    var temAlisamento: Bool = false
    var temTintura: Bool = false
    var temDescoloracao: Bool = false
    var temCaspa: Bool = false
    var temQueda: Bool = false
    var temFiosElasticos: Bool = false
    var produtoEhVegano: Bool = false
    var produtoEhCrueltyfree: Bool = false
    var produtoEhNoPooLowPoo: Bool = false
    var produtoNaoTemParabenoESimilares: Bool = false
    var produtoEhNatural: Bool = false
    var produtoEhAntiqueda: Bool = false
    var produtoEhAntifrizz: Bool = false
    var produtoEhAntinos: Bool = false
    var produtoDahBrilho: Bool = false
    var produtoDahMaciez: Bool = false
    var produtoDahHidratacao: Bool = false
    var produtoDahDefinicao: Bool = false
    var produtoDahCrescimento: Bool = false
    var produtoDahVolume: Bool = false
    var produtoControlaOleosidade: Bool = false
    var produtoControlaVolume: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case curvaturaCabelo
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
        case produtoNaoTemParabenoESimilares
        case produtoEhNatural
        case produtoEhAntiqueda
        case produtoEhAntifrizz
        case produtoEhAntinos
        case produtoDahBrilho
        case produtoDahMaciez
        case produtoDahHidratacao
        case produtoDahDefinicao
        case produtoDahCrescimento
        case produtoDahVolume
        case produtoControlaOleosidade
        case produtoControlaVolume
    }
}
