//
//  Endpoint.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import Foundation

import Foundation

struct Endpoint {
    var url: URL?
    var host: String = "http://quecabeleiraeessa-com-br.umbler.net"
    init() {
        url = URL(string: host)
    }
    init(withHost: String) {
        url = URL(string: withHost)
    }
    init(withPath: Path) {
        self.url = URL(string: host)
        url?.appendPathComponent(withPath.rawValue)
    }
    init(withPath: String) {
        self.url = URL(string: host)
        url?.appendPathComponent(withPath)
    }
}
