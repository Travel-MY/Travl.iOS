//
//  ImageSliderFooter.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 01/10/2021.
//

import UIKit

protocol BasePlannerImageFooterDelegate : AnyObject {
    func presentActionForFooterTap(_ BasePlannerImageFooter : BasePlannerImageFooter)
}
final class BasePlannerImageFooter: UITableViewHeaderFooterView {
    //MARK: - Outlets
    @IBOutlet weak var sliderScollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet var sliderImageView: [UIImageView]!
    //MARK: - Variables
    private weak var delegate : BasePlannerImageFooterDelegate?
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        sliderScollView.delegate = self
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.isHidden = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapOnFooter(_:)))
        contentView.addGestureRecognizer(tapRecognizer)
        contentView.addRoundedCorners()
        contentView.addCellPadding(top: 20)
    }
    
    func setViewDelegate(delegate : BasePlannerImageFooterDelegate) {
        self.delegate = delegate
    }
    
    func setFooterImages(_ data : [Images]) {
        contentView.isHidden = false
        sliderImageView[0].loadImage(url: data[0].imageURL)
        sliderImageView[1].loadImage(url: data[1].imageURL)
        sliderImageView[2].loadImage(url:data[2].imageURL)
        sliderImageView[3].loadImage(url: data[3].imageURL)
    }
    
    @objc private func didTapOnFooter( _ UITabGestureRecognizer : UITapGestureRecognizer) {
        delegate?.presentActionForFooterTap(self)
    }
}

//MARK: - UIScrollView Delegate
extension BasePlannerImageFooter : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(sliderScollView.contentOffset.x / Constants.Device.width)
        pageControl.currentPage = pageIndex
    }
}
