//
//  ItemOnlyImage.swift
//  Landatech iOS Template
//
//  Created by Francisco Landa Torres on 22/07/21.
//

import UIKit

class ItemOnlyImage: UICollectionViewCell {
    @IBOutlet var coverContentImage: UIImageView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    private var content : Any?
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    // Inicializador personalizado por IB
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initItem(data: Any, type: TypeContent){
        self.loadingIndicator.startAnimating()
        if type == .Movie {
            self.content = data as? Movie
            coverContentImage.downloadImage(url: "https://www.themoviedb.org/t/p/w440_and_h660_face" + (content as! Movie).poster_path, loaded: { (response) -> Void in
                if response == true {
                    
                }else{
                    
                }
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.isHidden = true
            })
        }else{
            self.content = data as? TV
        }
    }

}
