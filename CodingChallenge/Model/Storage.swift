//
//  Storage.swift
//  CodingChallenge
//
//  Created by Michelle M on 22/11/2019.
//  Copyright © 2019 iOSPractices. All rights reserved.
//

import Foundation

class Storage {
    static let shared: Storage = Storage()
    var obj: [ITunesSearchResult]
    
    private init() {
        obj = [ITunesSearchResult]()
    }
}
