//
//  Bindable.swift
//  NasaViewer
//
//  Created by Geovanni Oliveira de Jesus on 13/02/21.
//  Copyright © 2021 Geovanni Oliveira de Jesus. All rights reserved.
//

import Foundation

class Bindable<T> {
    
    typealias BindType = ((T) -> Void)
    
    var binds: [BindType] = []
    
    var value: T {
        didSet {
            execBinds()
        }
    }
    
    init(_ val: T) {
        value = val
    }
    
    func bind(skip: Bool = false, _ bind: @escaping BindType) {
        binds.append(bind)
        guard skip else {
            bind(value)
            return
        }
    }
    
    func remove() {
        _ = binds.popLast()
    }
    
    private func execBinds() {
        binds.forEach { [unowned self] bind in
            bind(self.value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
