//
//  Bindable.swift
//  NasaViewer
//
//  Created by Geovanni Oliveira de Jesus on 13/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
