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
    @IBOutlet var voteDescription: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var loaderIndicator: UIActivityIndicatorView!
    @IBOutlet var percentageLabel: UILabel!
    @IBOutlet var tagLabel: UILabel!
    @IBOutlet var firstAditionalInfo: UILabel!
    @IBOutlet var secondAditionalInfo: UILabel!
    
    private var infoContent: Any?
    private var typeContent: TypeContent?
    private var formatter: NumberFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController(){
        var poster = ""
        
        switch typeContent {
        case .Movie:
            let movie = infoContent as! MovieDetailed
            formatter = NumberFormatter()
            formatter?.locale = Locale(identifier: "es_MX")
            formatter?.numberStyle = .currency
            
            poster = movie.poster_path ?? ""
            titleLabel.text = movie.original_title
            contentView.text = movie.overview
            yearLabel.text = "\(movie.release_date.components(separatedBy: "-").first!) (\(movie.original_language.uppercased()))"
            percentageLabel.text = "\(movie.vote_average)"
            voteDescription.text = "Puntuación promedio de \(movie.vote_count) usuarios"
            tagLabel.text = movie.tagline
            firstAditionalInfo.text = "Presupuesto: " + (formatter?.string(from: NSDecimalNumber(decimal: Decimal(movie.budget))))!
            secondAditionalInfo.text = "Ingresos: " + (formatter?.string(from: NSDecimalNumber(decimal: Decimal(movie.revenue))))!
            break
        case .TVShows:
            let tvShow = infoContent as! TVDetailed
            poster = tvShow.poster_path ?? ""
            titleLabel.text = tvShow.name
            contentView.text = tvShow.overview
            yearLabel.text = "\(tvShow.first_air_date.components(separatedBy: "-").first!) (\(tvShow.original_language.uppercased()))"
            percentageLabel.text = "\(tvShow.vote_average)"
            voteDescription.text = "Puntuación promedio de \(tvShow.vote_count) usuarios"
            tagLabel.text = tvShow.tagline
            firstAditionalInfo.text = "Temporadas: \(tvShow.number_of_seasons)"
            secondAditionalInfo.text = "Capítulos: \(tvShow.number_of_episodes)"
            break
        default:
            break
        }
        
        loaderIndicator.startAnimating()
        coverImage.downloadImage(url: "https://www.themoviedb.org/t/p/w440_and_h660_face" + poster, loaded: { (response) -> Void in
            self.loaderIndicator.isHidden = true
        })
        
        
    }
    
    func setDetailedInfo(info: Any, type: TypeContent){
        if type == .Movie {
            self.infoContent = info as? MovieDetailed
        }else{
            self.infoContent = info as? TVDetailed
        }
        self.typeContent = type
    }
}
