//
//  TimelinePresenter.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 27/05/21.
//

import Foundation

protocol TimelineDelegate {
    func getTimeline()
}

class TimelinePresenter {
    weak var timelineView: TimelinePresenting?
    
    init() {
        //load
    }
    
    func attachView(view: TimelinePresenting) {
        self.timelineView = view
    }
}

extension TimelinePresenter: TimelineDelegate {
    func getTimeline() {
        let networking = Networking()
        guard let url = Endpoint(withPath: .timeline).url else {
            return
        }
        networking.request(url: url, method: .GET, header: nil, body: nil) { (data, response) in
            let response = response as HTTPURLResponse
            if Networking.switchResponseCode(response: response) == 200 {
                guard let timeline = networking.decodeFromJSON(type: Timelines.self, data: data) else {
                    return
                }
                self.timelineView?.setTimeline(timeline: timeline.data)
            }
        }
    }
}
