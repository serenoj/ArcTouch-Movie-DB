//
//  UIImageViewExtension.swift
//  ArcTouch Movie DB
//
//  Created by Juan Carlos Correa Arango on 1/28/19.
//  Copyright © 2019 ArcTouch. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    func setImage(url: String, placeholderImageName: String, completedBlock: SDExternalCompletionBlock? = nil) {
        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage.init(named: placeholderImageName), completed: completedBlock)
    }
    
}
