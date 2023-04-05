import Foundation
import StoreKit

class IAPManager: NSObject {
   
    
    static let shared = IAPManager()
    private override init(){}
    var products: [SKProduct] = []
    let paymentQueue = SKPaymentQueue.default()
    
    public func setupPurchases(callback: @escaping(Bool) -> ()){
        if SKPaymentQueue.canMakePayments() {
            paymentQueue.add(self)
            callback(true)
            return
        }
        callback(false)
    }
    
    public func getProducts(){
        let identifiers: Set<String> = [IAPProducts.consumable.rawValue]
        let productRequest = SKProductsRequest(productIdentifiers: identifiers)
        productRequest.delegate = self
        productRequest.start()
    }
    
    public func purchase(){
        guard let product = products.filter({$0.productIdentifier == "com.PinkoWinNew2023.consumable"}).first else {
            return
        }
        
        let payment = SKPayment(product: product)
        paymentQueue.add(payment)
    }
    
}

extension IAPManager: SKPaymentTransactionObserver{
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState{
                
            case .purchasing:
                break
            case .purchased:
                complated(transaction: transaction)
            case .failed:
                fail(transaction: transaction)
            case .restored:
                break
            case .deferred:
                break
            @unknown default:
                break
            }
        }
    }
    
    private func fail(transaction: SKPaymentTransaction){
        paymentQueue.finishTransaction(transaction)
    }
    private func complated(transaction: SKPaymentTransaction){
        paymentQueue.finishTransaction(transaction)
        var balance = 0
        if UserDefaults.standard.value(forKey: "balance") != nil{
            balance = UserDefaults.standard.integer(forKey: "balance")
        }
        balance += 1000
        FirebaseManager.shared.saveGold(gold: balance)
        UserDefaults.standard.set(balance, forKey: "balance")
    }
}

extension IAPManager: SKProductsRequestDelegate{
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        products.forEach{print($0.localizedTitle)}
        print("response.products\(response.products)")
    }
    
    func requestDidFinish(_ request: SKRequest) {
            print("Product request did finish")
        }
}
