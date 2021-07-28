//
//  MainRouter.swift
//  MyBluckbuster
//
//  Created by Francisco Landa Torres on 27/07/21.
//

import Foundation
import UIKit

class MainRouter {
    private var baseNavigation: UINavigationController? = nil
    static let shared = MainRouter()
    
    public static func sharedWith(navigation:UINavigationController) -> MainRouter {
        let instance = MainRouter.shared
        instance.baseNavigation = navigation
        return instance
    }
    
    func goDetailedInfoView(contentInfo: Any, type: TypeContent){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "detailedInfoVC") as? DetailedInfoVC
        vc?.setDetailedInfo(info: contentInfo, type: type)
        self.baseNavigation?.pushViewController(vc!, animated: true)
    }

}
