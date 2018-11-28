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


class FirstViewController: UIViewController,  UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {

    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var backgroundView: UIView!

    
    let transition = TransitionCoordinator()
    
    var cardView: CardCell?
    
    var selectedIndexPath: IndexPath!
    
    
    // DataSource for the collection
    var dictionaryDataArray: [[String: String]] =  [
        [
            "bottleName": "bottle1",
            "hexBackgroundColor": "761e30"
        ],
        [
            "bottleName": "bottle2",
            "hexBackgroundColor": "d86940"
        ],
        [
            "bottleName": "bottle3",
            "hexBackgroundColor": "363538"
        ],
        [
            "bottleName": "bottle4",
            "hexBackgroundColor": "ebb700"
        ],
        [
            "bottleName": "bottle5",
            "hexBackgroundColor": "8e5700"
        ],
        [
            "bottleName": "bottle6",
            "hexBackgroundColor": "44485b"
        ],
        [
            "bottleName": "bottle7",
            "hexBackgroundColor": "d6622f"
        ]
    ]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.collectionView.register(UINib(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: "cardCellIdentifier")
        self.collectionView.collectionViewLayout = AnimationCollectionViewLayout()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView.cellForItem(at: indexPath) as? CardCell) != nil {

            // Reference for the selected Cell
            self.selectedIndexPath = indexPath
            
            let finalVC = SecondViewController()
            finalVC.selectedImage = dictionaryDataArray[indexPath.row]["bottleName"]!
            finalVC.topHexColor = dictionaryDataArray[indexPath.row]["hexBackgroundColor"]!
            
            navigationController?.delegate = transition
            navigationController?.pushViewController(finalVC, animated: true)
            
            
        }
        
    }
    
     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.backgroundColor  =  self.dictionaryDataArray[indexPath.row]["hexBackgroundColor"]!.hexColor
        }
        

    }
    


    
}

// MARK: - DataSource
extension FirstViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dictionaryDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCellIdentifier", for: indexPath) as! CardCell        
        cell.setupCell(imgViewName: dictionaryDataArray[indexPath.row]["bottleName"]!)
        
        return cell
    }
}

// MARK: - Protocol for Transition
extension FirstViewController : animTransitionable
{
    var cellImageView: UIImageView {
        if let indexPath = selectedIndexPath {
            let cell = collectionView?.cellForItem(at: indexPath) as! CardCell
            return cell.imageView
        }
        return UIImageView()
    }
    
    var backgroundColor: UIView {
        return backgroundView
    }
    
    var cellBackground: UIView {
        if let indexPath = selectedIndexPath {
            let cell = collectionView?.cellForItem(at: indexPath) as! CardCell
            return cell.cellBackground
        }
        return UIView()
    }
    
    
    
   
    
}





