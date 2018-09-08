//
//  BarIndicatorContainer.swift
//  Tabman
//
//  Created by Merrick Sapsford on 02/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

internal final class BarIndicatorContainer<IndicatorType: BarIndicator>: UIView {
    
    // MARK: Properties
    
    private(set) var layoutHandler: BarIndicatorLayoutHandler!
    
    // MARK: Init
    
    init(for indicator: IndicatorType) {
        super.init(frame: .zero)
        layout(indicator: indicator)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: Layout
    
    private func layout(indicator: IndicatorType) {
        guard indicator.superview == nil else {
            fatalError("Indicator already has a superview.")
        }
        
        addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        let leading = indicator.leadingAnchor.constraint(equalTo: leadingAnchor)
        let top = indicator.topAnchor.constraint(equalTo: topAnchor)
        let bottom = indicator.bottomAnchor.constraint(equalTo: bottomAnchor)
        let width = indicator.widthAnchor.constraint(equalToConstant: 0.0)
        
        NSLayoutConstraint.activate([leading, top, bottom, width])
        self.layoutHandler = BarIndicatorLayoutHandler(leading: leading,
                                                       width: width)
    }
}