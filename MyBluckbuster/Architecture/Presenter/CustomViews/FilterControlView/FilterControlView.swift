//
//  FilterControlView.swift
//  Landatech iOS Template
//
//  Created by Francisco Landa Torres on 23/07/21.
//

import UIKit

protocol FilterControlDelegate{
    func mainFilterSelection()
    func secondaryFilterSelection()
}

class FilterControlView: UIView {
    var delegate: FilterControlDelegate?

    @IBOutlet var mainFilterControl: UISegmentedControl!
    @IBOutlet var secundaryFilterControl: UISegmentedControl!
    @IBOutlet var heightSecundaryFilterView: NSLayoutConstraint!
    
    @IBAction func mainFilterControlAction(_ sender: Any) {
        delegate?.mainFilterSelection()
    }
    
    @IBAction func secundaryFilterControlAction(_ sender: Any) {
        delegate?.secondaryFilterSelection()
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
