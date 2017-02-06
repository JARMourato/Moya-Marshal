import UIKit
import Moya
import RxSwift
import ReactiveSwift

class ViewController: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        onlyMoya()
        usingReactiveCocoa()
        usingRxSwift()
    }
    func onlyMoya(){
        regularProvider.request(ExampleAPI.object) { (result) -> () in
            switch result {
            case let .success(response):
                do {
                    let object = try response.map(to: User.self)
                    print("Only moya : \(object)")
                } catch {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func usingReactiveCocoa(){
        rcProvider
            .request(ExampleAPI.object)
            .map(to: User.self)
            .on(failed: { (error) -> () in
                print(error)
            }) { (response) -> () in
                print("Reactive cocoa: \(response)")
            }
            .start()
    }
    
    func usingRxSwift(){
        rxProvider
            .request(ExampleAPI.array)
            .mapArray(of: User.self)
            .subscribe(onNext: { (response) -> Void in
                print("Rx Swift \(response)")
            }, onError: { (error) -> Void in
                print(error)
            })
            .addDisposableTo(disposeBag)
    }
}

