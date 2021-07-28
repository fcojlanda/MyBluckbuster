//
//  MainVC.swift
//  MyBluckbuster
//
//  Created by Francisco Landa Torres on 23/07/21.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet var headerView: UIView!
    @IBOutlet var mainCollection: UICollectionView!
    
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
        self.mainCollection.dataSource = self
        self.mainCollection.delegate = self
        self.mainCollection.register(UINib(nibName: "ItemOnlyImage", bundle: nil), forCellWithReuseIdentifier: "itemOnlyImage")
        
        let filterView = FilterControlView(parentFrame: headerView.frame, mainFilters: ["Categoría 1","Categoría 2", "Categoría 3"], secundaryFilters: ["Subcategoría 1", "Subcategoría 2"])
        headerView.addSubview(filterView)
        
        movies = [Movie]()
        
        ServicesManager.shared.getMovies(to: "/discover/movie", whenFinish: { (status, movies, error) -> Void in
            DispatchQueue.main.async {
                if status == true {
                    self.movies = movies as? [Movie]
                }else{
                    
                }
                self.mainCollection.reloadData()
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemOnlyImage", for: indexPath) as! ItemOnlyImage
        cell.initItem(data: movies![indexPath.row], type: .Movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        MainRouter.sharedWith(navigation: self.navigationController!).goDetailedInfoView(contentInfo: movies![indexPath.row], type: .Movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = self.view.bounds.width / 5
        let height = width * 1.3
        return CGSize(width: width, height: height)
    }
}
