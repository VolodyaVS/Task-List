//
//  LaunchScreenViewController.swift
//  Task List
//
//  Created by Vladimir Stepanchikov on 12.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class LaunchScreenManager {
    // MARK: - Properties

    static let instance = LaunchScreenManager(animationDurationBase: 1.3)
    
    var mainView: UIView?
    var parentView: UIView?
    
    let animationDurationBase: Double

    let logoVigetViewTag = 102
    
    // MARK: - Lifecycle

    init(animationDurationBase: Double) {
        self.animationDurationBase = animationDurationBase
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Animate

    func animateAfterLaunch(_ parentViewPassedIn: UIView) {
        parentView = parentViewPassedIn
        mainView = loadView()
        
        fillParentViewWithView()
        
        hideLogo()
        hideRingSegments()
    }
    
    func loadView() -> UIView {
        return UINib(nibName: "LaunchScreen", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func fillParentViewWithView() {
        parentView!.addSubview(mainView!)
        
        mainView!.frame = parentView!.bounds
        mainView!.center = parentView!.center
    }
    
    func hideLogo() {
        let logoViget = mainView!.viewWithTag(logoVigetViewTag)!
        
        UIView.animate(
            withDuration: animationDurationBase / 4,
            delay: animationDurationBase / 3,
            options: .curveEaseOut,
            animations: {
                logoViget.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            },
            completion: { _ in
                UIView.animate(
                    withDuration: self.animationDurationBase / 6,
                    delay: 0,
                    options: .curveEaseIn,
                    animations: {
                        logoViget.alpha = 0
                        logoViget.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    }
                )
            }
        )
    }
    
    func hideRingSegments() {
        let distanceToMove = parentView!.frame.size.height * 1.75
        
        for number in 1 ... 12 {
            let ringSegment = mainView!.viewWithTag(number)!
            
            // Get the degrees we want to move to
            let degrees = 360 - (number * 30) + 15
            
            // Convert to float
            let angle = CGFloat(degrees)
            
            // Convert to radians
            let radians = angle * (CGFloat.pi / 180)
            
            // Calculate the final X value from this angle and the total distance.
            let translationX = (cos(radians) * distanceToMove)
            let translationY = (sin(radians) * distanceToMove) * -1
            
            UIView.animate(
                withDuration: animationDurationBase * 1.75,
                delay: animationDurationBase / 1.5,
                options: .curveLinear,
                animations: {
                    var transform = CGAffineTransform.identity
                    transform = transform.translatedBy(x: translationX, y: translationY)
                    
                    // This rotation accounts for the curve in the segment images.
                    transform = transform.rotated(by: -1.95)
                    
                    ringSegment.transform = transform
                }
            )
            
            // When segments are very curved, sometimes pieces of them reappear on-screen
            // before the animation finishes. This timer stops the animation early and removes
            // the entire view.
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDurationBase * 1.25) {
                self.mainView!.removeFromSuperview()
            }
        }
    }
}
