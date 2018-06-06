//
//  BarView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 28/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit

open class BarView<LayoutType: BarLayout, BarButtonType: BarButton>: UIView, LayoutPerformer {
    
    // MARK: Properties
    
    public let layout = LayoutType()
    
    public private(set) var buttons: [BarButtonType]?
    
    // MARK: Init
    
    public required init() {
        super.init(frame: .zero)
        performLayout(in: self)
        
        self.backgroundColor = .red
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("BarView does not support Interface Builder")
    }
    
    // MARK: Construction
    
    public private(set) var hasPerformedLayout = false
    
    public func performLayout(in view: UIView) {
        guard !hasPerformedLayout else {
            fatalError("performLayout() can only be called once.")
        }
        
        let layoutContainer = layout.container
        view.addSubview(layoutContainer)
        layoutContainer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

public extension BarView {
    
    public func populate(with items: [BarItem],
                         configure: ((BarButtonType, BarItem) -> Void)? = nil) {
        
        let barButtons: [BarButtonType] = items.map({ item in
            let button = BarButtonType()
            button.populate(for: item)
            return button
        })
        self.buttons = barButtons
        layout.clear()
        layout.populate(with: barButtons)
        
        if let configure = configure {
            for (index, button) in barButtons.enumerated() {
                let item = items[index]
                configure(button, item)
            }
        }
    }
}