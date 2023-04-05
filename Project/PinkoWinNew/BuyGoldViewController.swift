//
//  BuyGoldViewController.swift
//  PinkoWinNew
//
//  Created by Roma Bogatchuk on 05.04.2023.
//

import UIKit

class BuyGoldViewController: UIViewController {
    @IBOutlet weak var buyButton: UIButton!
    let iapManager = IAPManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()

        buyButton.layer.cornerRadius = 20
    }
    

    @IBAction func buyGoldButtonClicked(_ sender: UIButton) {
        iapManager.purchase()
    }

}
