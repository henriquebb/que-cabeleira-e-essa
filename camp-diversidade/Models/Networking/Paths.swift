//
//  Paths.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import Foundation

enum Path: String {
    case signup = "api/v1/usuario"
    case tips = "api/v1/dica"
    case products = "api/v1/produto"
    case userProducts = "api/v1/produto/usuario"
    case userTips = "api/v1/dica/usuario"
    case timeline = "api/v1/decada"
}
