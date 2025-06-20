//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 16/06/25.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let cache = NetworkManager.shared.cache
    let placeholderImage: UIImage = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.bounds.width / 2
    }
    
    private func configure() {
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
    }
    
    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if error != nil { return }
            guard let self = self,
                let data = data,
                let image = UIImage(data: data) else { return }
                
                self.cache.setObject(image, forKey: cacheKey)
                
                DispatchQueue.main.async {
                    self.image = image
                }
        }
        
        task.resume()
    }
}
