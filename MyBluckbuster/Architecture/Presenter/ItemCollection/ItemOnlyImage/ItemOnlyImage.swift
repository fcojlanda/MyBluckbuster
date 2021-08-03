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
    @IBOutlet var rateLabel: UILabel!
    
    private var content : Any?
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    // Inicializador personalizado por IB
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initItem(data: Any, type: TypeContent, vote: Double){
        self.layer.cornerRadius = 10
        self.loadingIndicator.startAnimating()
        if type == .Movie {
            self.content = data as? Movie
            coverContentImage.downloadImage(url: "https://www.themoviedb.org/t/p/w440_and_h660_face" + ((content as! Movie).poster_path ?? ""), loaded: { (response) -> Void in
                if response == false{
                    self.coverContentImage.image = UIImage(named: "content")
                }
                self.loadingIndicator.isHidden = true
            })
        }else{
            self.content = data as? TV
            coverContentImage.downloadImage(url: "https://www.themoviedb.org/t/p/w440_and_h660_face" + ((content as! TV).poster_path ?? ""), loaded: { (response) -> Void in
                if response == false{
                    self.coverContentImage.image = UIImage(named: "content")
                }
                self.loadingIndicator.isHidden = true
            })
        }
        rateLabel.text = "\(vote)/10"
    }

}
