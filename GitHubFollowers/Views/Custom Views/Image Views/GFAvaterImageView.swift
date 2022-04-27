//
//  GFAvaterImageView.swift
//  GitHubFollowers
//
//  Created by Abdullah Al Sohel on 4/14/22.
//

import UIKit

class GFAvaterImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = UIImage(named: Images.placeHolder)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
