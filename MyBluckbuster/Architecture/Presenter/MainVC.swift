//
//  MainVC.swift
//  MyBluckbuster
//
//  Created by Francisco Landa Torres on 23/07/21.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FilterControlDelegate {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var mainCollection: UICollectionView!
    var firstFilterParams: [[String: Any]]?
    var contentToShow: TypeContent? = .None
    var filterToShow: FitlerContent? = .None
    var secondFilterParams:[[String: Any]]?
    var movies: [Movie]?
    var tvShows: [TV]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func initViewController(){
        self.title = "My Bluckbuster"
        
        self.mainCollection.dataSource = self
        self.mainCollection.delegate = self
        self.mainCollection.register(UINib(nibName: "ItemOnlyImage", bundle: nil), forCellWithReuseIdentifier: "itemOnlyImage")
        
        firstFilterParams = [[String: Any]]()
        secondFilterParams = [[String: Any]]()
        
        firstFilterParams?.append(["title": "Películas"])
        firstFilterParams?.append(["title": "Series"])
        
        secondFilterParams?.append(["title": "Popular"])
        secondFilterParams?.append(["title": "Las mejores"])
        secondFilterParams?.append(["title": "Próximamente"])
        
        let filterView = FilterControlView(
            parentFrame: headerView.frame,
            mainFilters: firstFilterParams!.map{ $0["title"] as! String },
            secundaryFilters: secondFilterParams!.map{ $0["title"] as! String} )
        filterView.delegate = self
        headerView.addSubview(filterView)
        
        movies = [Movie]()
        tvShows = [TV]()
        
        ServicesManager.shared.getListContent(typeContent: .Movie, filter: filterToShow!, whenFinish: { (status, content, error) -> Void in
            if status {
                self.movies = content as? [Movie]
            }else{
                
            }
            
        })
        
        ServicesManager.shared.getListContent(typeContent: .TVShows, filter: filterToShow!, whenFinish: { (status, content, error) -> Void in
            if status {
                self.tvShows = content as? [TV]
            }else{
                
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch contentToShow {
        case .Movie:
            return self.movies!.count
        case .TVShows:
            return self.tvShows!.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch contentToShow {
        case .Movie:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemOnlyImage", for: indexPath) as! ItemOnlyImage
            cell.initItem(data: movies![indexPath.row], type: .Movie, vote: movies![indexPath.row].vote_average)
            return cell
        case .TVShows:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemOnlyImage", for: indexPath) as! ItemOnlyImage
            cell.initItem(data: tvShows![indexPath.row], type: .TVShows, vote: tvShows![indexPath.row].vote_average)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemOnlyImage", for: indexPath) as! ItemOnlyImage
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch contentToShow! {
        case .Movie:
            let movieSelected = movies![indexPath.row]
            ServicesManager.shared.getDetailContent(idContent: movieSelected.id, typeContent: .Movie, whenFinish: { (status, content, error) -> Void in
                DispatchQueue.main.async {
                    if status && (content != nil){
                        MainRouter.sharedWith(navigation: self.navigationController!).goDetailedInfoView(contentInfo: content as! MovieDetailed, type: .Movie)
                    }
                }
            })
            break
        case .TVShows:
            let tvShowSelected = tvShows![indexPath.row]
            ServicesManager.shared.getDetailContent(idContent: tvShowSelected.id, typeContent: .TVShows, whenFinish: { (status, content, error) -> Void in
                DispatchQueue.main.async {
                    if status && (content != nil){
                        MainRouter.sharedWith(navigation: self.navigationController!).goDetailedInfoView(contentInfo: content as! TVDetailed, type: .TVShows)
                    }
                }
            })
            break
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = self.mainCollection.frame.width / 3
        let height = width * 1.3
        return CGSize(width: width, height: height)
    }
    
    func selection(content: TypeContent, filter: FitlerContent) {
        contentToShow = content
        
        filterToShow = filter
        
        ServicesManager.shared.getListContent(typeContent: contentToShow!, filter: filterToShow!, whenFinish: { (status, content, error) -> Void in
            DispatchQueue.main.async {
                if status {
                    switch self.contentToShow! {
                    case .Movie:
                        self.movies = content as? [Movie]
                        break
                    case .TVShows:
                        self.tvShows = content as? [TV]
                        break
                    default:
                        break
                    }
                }else{
                    
                }
                
                self.mainCollection.reloadData()
            }
        })
    }
}
