//
//  UIImageViewExtension.swift
//  MyBluckbuster
//
//  Created by Francisco Landa Torres on 27/07/21.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(url: String, loaded: @escaping (Bool) -> Void ){
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.image = UIImage(data: data!)
                    loaded(true)
                }else{
                    loaded(false)
                }
            }
        }.resume()
    }
}
