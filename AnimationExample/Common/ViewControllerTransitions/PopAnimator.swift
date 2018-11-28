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

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
      
    
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
        imageViewSnapshot.frame = containerView.convert(fromVC.cellImageView.frame, from: fromVC.cellImageView.superview)
        
        
        //Background View With Correct Color
        let backgroundView = UIView()
        backgroundView.frame = fromVC.backgroundColor.frame
        backgroundView.backgroundColor = fromVC.backgroundColor.backgroundColor

        // Cell Background
        let cellBackground = UIView()
        cellBackground.frame =  containerView.convert(fromVC.cellBackground.frame, from: fromVC.cellBackground.superview)
        cellBackground.backgroundColor = fromVC.cellBackground.backgroundColor

        let cellBackgroundToVC = containerView.convert(toVC.cellBackground.frame, from: toVC.cellBackground.superview)
        let imageViewToVC = containerView.convert(toVC.cellImageView.frame, from: toVC.cellImageView.superview)

        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(cellBackground)
        containerView.addSubview(imageViewSnapshot)
        
        fromViewController.view.isHidden = true
        toViewController.view.isHidden = true
        

        
        let frameAnim1 = CGRect(x: fromVC.cellBackground.frame.minX, y: cellBackgroundToVC.minY , width: UIScreen.main.bounds.width, height: cellBackgroundToVC.height)
        let frameAnim2 = CGRect(x: cellBackgroundToVC.minX, y: cellBackgroundToVC.minY, width: cellBackgroundToVC.width, height: cellBackgroundToVC.height )
        let frameImageToVC = containerView.convert(toVC.cellImageView.frame, from: toVC.cellImageView.superview)
        
        
        let animator1 = {
            UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
                cellBackground.frame = frameAnim1
            }
        }()
        
       
        
        let animator2 = {
            UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
                imageViewSnapshot.frame = CGRect(x: frameImageToVC.minX, y: cellBackgroundToVC.minY - (toVC.cellImageView.frame.height / 2) , width: imageViewToVC.width, height: imageViewToVC.height)
            }
        }()
        
        let animator3 = {
            UIViewPropertyAnimator(duration: 0.35, dampingRatio: 0.6) {
                cellBackground.frame = frameAnim2
                cellBackground.layer.cornerRadius = 10

                imageViewSnapshot.frame = frameImageToVC
                
            }
        }()

        
        // Animations Completion Handler
        animator1.addCompletion {  _ in
             animator3.startAnimation()
        }
        
        animator3.addCompletion { _ in
            
            imageViewSnapshot.removeFromSuperview()
            cellBackground.removeFromSuperview()
            
            toViewController.view.isHidden = false
            
            transitionContext.completeTransition(true)
        }
        
        
        
        animator1.startAnimation()
        animator2.startAnimation()
        
        
    }
}

