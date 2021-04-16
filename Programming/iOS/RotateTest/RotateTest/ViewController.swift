//
//  ViewController.swift
//  RotateTest
//
//  Created by Ethan on 2021/04/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView?
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout?

    private var centerIndexPath: IndexPath? {
        guard let collectionView = self.collectionView else {
            return nil
        }

        let center = self.view.convert(collectionView.center, to: collectionView)
        let indexPath = collectionView.indexPathForItem(at: center)

        return indexPath
    }

    private var previousIndexPathForRotate: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        self.previousIndexPathForRotate = self.centerIndexPath
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }

}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? Cell else { return UICollectionViewCell() }

        cell.configure(index: indexPath.row)

        return cell
    }

}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }


    func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        guard let oldCenter = self.previousIndexPathForRotate,
              let attribute = collectionView.layoutAttributesForItem(at: oldCenter) else { return proposedContentOffset }

        return attribute.frame.origin
    }

}

class Cell: UICollectionViewCell {

    @IBOutlet private weak var indexLabel: UILabel?

    func configure(index: Int) {
        self.indexLabel?.text = "\(index)"
    }

}
