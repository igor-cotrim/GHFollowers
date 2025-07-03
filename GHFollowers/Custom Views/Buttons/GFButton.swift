//
//  GFButton.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 10/06/25.
//

import UIKit

class GFButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor, title: String, systemImage: UIImage) {
        self.init(frame: .zero)
        
        setup(color: color, title: title, systemImage: systemImage)
    }
    
    private func configure() {
        configuration = .tinted()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setup(color: UIColor, title: String, systemImage: UIImage) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title
        configuration?.image = systemImage
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
    }
}

#Preview {
    GFButton(color: .red, title: "Set Date", systemImage: UIImage(systemName: "calendar")!)
}
