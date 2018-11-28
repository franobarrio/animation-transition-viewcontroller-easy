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

class AnimationCollectionViewLayout: UICollectionViewFlowLayout {

    // Cell Size for each resolution
     var cellSize = CGSize(
        width: (UIScreen.main.bounds.width * 92) / 100,
        height: (UIScreen.main.bounds.height * 71) / 100
    )
    
    
    var contentInsetLeft: CGFloat = 30.0
    var contentInsetRight: CGFloat = 30.0

    required override init() {
        super.init()

        self.scrollDirection = .horizontal
        self.itemSize = self.cellSize
        self.minimumInteritemSpacing = 20.0
        self.minimumLineSpacing = 20.0
        self.sectionInset = UIEdgeInsets(top: 70, left: 0, bottom: 0, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        super.prepare()
        
        if let collectionView = collectionView {
            
            let frameSize = collectionView.bounds.width
            
            // leading & trailing for each cell
            self.contentInsetLeft = frameSize / 2 - self.cellSize.width / 2
            self.contentInsetRight = frameSize / 2 - self.cellSize.width / 2
                        
            collectionView.decelerationRate = UIScrollViewDecelerationRateFast
            collectionView.contentInset = UIEdgeInsets(top: 0, left: contentInsetLeft, bottom: 0, right: contentInsetRight)
            
  
        }
    }
 
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    
    // This method makes the cell centered
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let width = cellSize.width + self.minimumLineSpacing
        var newOffset: CGPoint = CGPoint.zero
        var offset = proposedContentOffset.x + self.contentInsetLeft
        
        if velocity.x > 0 {
            offset = width * ceil(offset / width)
        } else if velocity.x == 0 {
            offset = width * round(offset / width)
        } else if velocity.x < 0 {
            
            offset = width * floor(offset / width)
        }

        newOffset.x = offset - self.contentInsetLeft
        newOffset.y = proposedContentOffset.y
        
        return newOffset
        
    }

    
    
}
