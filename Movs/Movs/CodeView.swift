//
//  CodeView.swift
//  Movs
//
//  Created by gustavo.cosenza on 01/07/19.
//  Copyright © 2019 Gustavo. All rights reserved.
//

protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupViews()
}

extension CodeView {
    func setupViews() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration() { }
}
