//
//  ImageSliderFooter.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 01/10/2021.
//

import UIKit

final class BasePlannerImageFooter: UITableViewHeaderFooterView {

    //MARK:- Variables
    @IBOutlet weak var sliderScollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK:- LifeCycles
    override func awakeFromNib() {
        super.awakeFromNib()
        sliderScollView.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
        contentView.layer.cornerRadius = 10
    }
}

//MARK:- UIScrollView Delegate
extension BasePlannerImageFooter : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = Int(sliderScollView.contentOffset.x / Constants.Device.width)
        pageControl.currentPage = pageIndex
        
    }
}
