//
//  FilterControlView.swift
//  Landatech iOS Template
//
//  Created by Francisco Landa Torres on 23/07/21.
//

import UIKit

protocol FilterControlDelegate{
    func selection(content: TypeContent, filter: FitlerContent)
}

class FilterControlView: UIView {
    var delegate: FilterControlDelegate?

    @IBOutlet var mainFilterControl: UISegmentedControl!
    @IBOutlet var secundaryFilterControl: UISegmentedControl!
    @IBOutlet var heightSecundaryFilterView: NSLayoutConstraint!
    
    @IBAction func mainFilterControlAction(_ sender: Any) {
        let typeContent = TypeContent.mapTypeContent(index: mainFilterControl.selectedSegmentIndex)
        let filterContent = FitlerContent.mapFilterContent(index: secundaryFilterControl.selectedSegmentIndex)
        delegate?.selection(content: typeContent, filter: filterContent)
    }
    
    @IBAction func secundaryFilterControlAction(_ sender: Any) {
        let typeContent = TypeContent.mapTypeContent(index: mainFilterControl.selectedSegmentIndex)
        let filterContent = FitlerContent.mapFilterContent(index: secundaryFilterControl.selectedSegmentIndex)
        delegate?.selection(content: typeContent, filter: filterContent)
    }
    
    init(parentFrame frame: CGRect,mainFilters: [String], secundaryFilters: [String]? = nil){
        super.init(frame: frame)
        filterControlViewInit()
        mainFilterControl.removeAllSegments()
        for index in 0...mainFilters.count - 1 {
            mainFilterControl.insertSegment(withTitle: mainFilters[index], at: index, animated: false)
        }
        if secundaryFilters == nil{
            heightSecundaryFilterView.constant = 0
        }else {
            secundaryFilterControl.removeAllSegments()
            for index in 0...secundaryFilters!.count - 1 {
                secundaryFilterControl.insertSegment(withTitle: secundaryFilters![index], at: index, animated: false)
            }
        }
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "textSelectedFilter")]
        mainFilterControl.setTitleTextAttributes(titleTextAttributes as [NSAttributedString.Key : Any], for: .selected)
        secundaryFilterControl.setTitleTextAttributes(titleTextAttributes as [NSAttributedString.Key : Any], for: .selected)
        if #available(iOS 13.0, *) {
            mainFilterControl.selectedSegmentTintColor = UIColor(named: "selectedFilter")
            secundaryFilterControl.selectedSegmentTintColor = UIColor(named: "selectedFilter")
        } else {
            mainFilterControl.tintColor = UIColor(named: "selectedFilter")
            secundaryFilterControl.tintColor = UIColor(named: "selectedFilter")
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        filterControlViewInit()
    }
    
    private func filterControlViewInit(){
        let view = self.loadNIB()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.frame = bounds
        self.addSubview(view)
    }
    
}
