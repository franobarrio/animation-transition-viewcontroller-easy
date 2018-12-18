/*
 * Copyright (c) Francisco Obarrio - fobarrio@gmail.com -  https://twitter.com/fran_obarrio
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * Basically ... Feel Free to use this code as you want !
 * BTW I'm available for freelance work :D
 */

import UIKit

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView        
        
        guard let fromVC = transitionContext.viewController(forKey: .from) as? animTransitionable,
            let toVC = transitionContext.viewController(forKey: .to) as? animTransitionable else {
                transitionContext.completeTransition(false)
                return
        }
        
        let fromViewController = transitionContext.viewController(forKey: .from)!
        fromViewController.view.backgroundColor = UIColor.clear
        
        let toViewController = transitionContext.viewController(forKey: .to)!
        
        let imageViewSnapshot = UIImageView(image: fromVC.cellImageView.image)
        imageViewSnapshot.contentMode = .scaleAspectFit
        
        
        // Background View With Correct Color
        let backgroundView = UIView()
        backgroundView.frame = fromVC.backgroundColor.frame
        backgroundView.backgroundColor = fromVC.backgroundColor.backgroundColor
        containerView.addSubview(backgroundView)
        
        
        // Cell Background
        let cellBackground = UIView()
        cellBackground.frame =  containerView.convert(fromVC.cellBackground.frame, from: fromVC.cellBackground.superview)
        cellBackground.backgroundColor = fromVC.cellBackground.backgroundColor
        cellBackground.layer.cornerRadius = fromVC.cellBackground.layer.cornerRadius
        cellBackground.layer.masksToBounds = fromVC.cellBackground.layer.masksToBounds
        
        
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toViewController.view)
        
        containerView.addSubview(cellBackground)
        containerView.addSubview(imageViewSnapshot)
        
        fromViewController.view.isHidden = true
        toViewController.view.isHidden = true
        
        
        imageViewSnapshot.frame = containerView.convert(fromVC.cellImageView.frame, from: fromVC.cellImageView.superview)
        
        
        let frameAnim1 = CGRect(x: 0, y: cellBackground.frame.minY, width: UIScreen.main.bounds.width, height: cellBackground.frame.height)
        let frameAnim2 = CGRect(x: 0, y: toVC.cellBackground.frame.minY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - toVC.cellBackground.frame.minY)
        
        
        let animator1 = {
            UIViewPropertyAnimator(duration: 0.4, dampingRatio: 1.3) {
                cellBackground.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        }()
        
        let animator2 = {
            UIViewPropertyAnimator(duration: 0.3, dampingRatio: 0.9) {
                cellBackground.layer.cornerRadius = 0
                cellBackground.frame = frameAnim1
            }
        }()
        
        let animator3 = {
            UIViewPropertyAnimator(duration: 0.2, dampingRatio: 1.4) {
                cellBackground.frame = frameAnim2
                imageViewSnapshot.frame = containerView.convert(toVC.cellImageView.frame, from: toVC.cellImageView.superview)
            }
        }()
        
        
        animator1.addCompletion { _ in
            animator2.startAnimation()
        }
        
        animator2.addCompletion {  _ in
            animator3.startAnimation(afterDelay: 0.1)
        }
        
        
        animator3.addCompletion {  _ in
            
            imageViewSnapshot.removeFromSuperview()
            cellBackground.removeFromSuperview()
            fromViewController.view.removeFromSuperview()
            
            toViewController.view.isHidden = false
            
            transitionContext.completeTransition(true)

            
        }
        
        animator1.startAnimation()
        
    }
}
