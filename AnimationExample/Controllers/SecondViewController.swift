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


class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageBottle: UIImageView!
    @IBOutlet weak var topBackground: UIView!
    @IBOutlet weak var bottomBackground: UIView!
    
    var selectedImage: String?
    
    var topHexColor: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topColor = topHexColor {
            topBackground.backgroundColor =  topColor.hexColor
        }
        if let imageToLoad = selectedImage {
            imageBottle.image  = UIImage(named: imageToLoad)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissTap))
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

// MARK: - Protocol for Transition
extension SecondViewController : animTransitionable
{
    var cellImageView: UIImageView {
        return imageBottle
    }
    
    var backgroundColor: UIView {
        return topBackground
    }
    
    var cellBackground: UIView {
        return bottomBackground
    }
    
}

