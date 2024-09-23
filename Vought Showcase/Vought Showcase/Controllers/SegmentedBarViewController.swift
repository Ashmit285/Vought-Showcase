//
//  SegmentedBarViewController.swift
//  Vought Showcase
//
//  Created by Ashmit Goel on 23/09/24.
//

import UIKit

final class SegmentedBarViewController: UIViewController, SegmentedProgressBarDelegate {
    
    var images: [String] = ["hughei", "butcher", "frenchie", "mm"]
    var currentIndex = 0
    var imageView: UIImageView!
    var segmentedProgressBar: SegmentedProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupView()
        setupSegmentedProgressBar()
    }
    
    func setupView() {
        imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        let tapRight = UITapGestureRecognizer(target: self, action: #selector(nextStory))
        tapRight.numberOfTapsRequired = 1
        let tapLeft = UITapGestureRecognizer(target: self, action: #selector(prevStory))
        tapLeft.numberOfTapsRequired = 1
        tapLeft.require(toFail: tapRight)
        
        let rightSide = UIView(frame: CGRect(x: view.bounds.width / 2, y: 0, width: view.bounds.width / 2, height: view.bounds.height))
        let leftSide = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width / 2, height: view.bounds.height))
        
        view.addSubview(rightSide)
        view.addSubview(leftSide)
        
        rightSide.addGestureRecognizer(tapRight)
        leftSide.addGestureRecognizer(tapLeft)
        
        updateStory()
    }
    
    func setupSegmentedProgressBar() {
        segmentedProgressBar = SegmentedProgressBar(numberOfSegments: images.count, duration: 5.0)
        segmentedProgressBar.delegate = self
        segmentedProgressBar.frame = CGRect(x: 10, y: 60, width: view.bounds.width - 20, height: 4)
        view.addSubview(segmentedProgressBar)
        segmentedProgressBar.startAnimation()
    }
    
    func updateStory() {
        let story = images[currentIndex]
        imageView.image = UIImage(named: story)
    }
    
    @objc func nextStory() {
        if currentIndex < images.count - 1 {
            currentIndex += 1
            updateStory()
            segmentedProgressBar.skip()
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func prevStory() {
        if currentIndex > 0 {
            currentIndex -= 1
            updateStory()
            segmentedProgressBar.rewind()
        }
    }
    
    func segmentedProgressBarChangedIndex(index: Int) {
        currentIndex = index
        updateStory()
    }
    
    func segmentedProgressBarFinished() {
        dismiss(animated: true, completion: nil)
    }
}
