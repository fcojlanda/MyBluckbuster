//
//  DetailedInfoVC.swift
//  MyBluckbuster
//
//  Created by Francisco Landa Torres on 27/07/21.
//

import UIKit

class DetailedInfoVC: UIViewController {
    @IBOutlet var coverImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentView: UITextView!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var playTrailerView: UIView!
    @IBOutlet var loaderIndicator: UIActivityIndicatorView!
    @IBOutlet var percentageLabel: UILabel!
    private var infoContent: Any?
    private var typeContent: TypeContent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController(){
        var poster = ""
        if (typeContent == .Movie){
            let movie = infoContent as! Movie
            poster = movie.poster_path
            titleLabel.text = movie.original_title
            contentView.text = movie.overview
            yearLabel.text = movie.release_date!.components(separatedBy: "-").first
            percentageLabel.text = "\(movie.vote_average)"
        }else{
            poster = (infoContent as? TV)!.backdrop_path
        }
        loaderIndicator.startAnimating()
        coverImage.downloadImage(url: "https://www.themoviedb.org/t/p/w440_and_h660_face" + poster, loaded: { (response) -> Void in
            self.loaderIndicator.stopAnimating()
        })
        
        
    }
    
    func setDetailedInfo(info: Any, type: TypeContent){
        if type == .Movie {
            self.infoContent = info as? Movie
        }else{
            self.infoContent = info as? TV
        }
        self.typeContent = type
    }
}
