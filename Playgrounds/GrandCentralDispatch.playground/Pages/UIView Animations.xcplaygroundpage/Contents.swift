
import UIKit
import PlaygroundSupport


extension UIView {
    
    static func animate(withDuration duration: TimeInterval, animations: @escaping () -> Void, group: DispatchGroup, completion: ((Bool) -> Void)? = nil) {
        
        group.enter()
        animate(withDuration: duration, animations: animations) { success in
            completion?(success)
            group.leave()
        }
    }
}

let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200) ) )
view.backgroundColor = .red
let box = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 40) ) )
box.backgroundColor = .yellow

view.addSubview(box)


PlaygroundPage.current.liveView = view


let group = DispatchGroup()

UIView.animate(withDuration: 1, animations: {
    box.center = CGPoint(x: 150, y: 150)
}, group: group, completion: { _ in
    UIView.animate(withDuration: 2, animations: {
        box.transform = CGAffineTransform(rotationAngle: .pi/2)
    }, group: group, completion: { _ in
        UIView.animate(withDuration: 1, animations: {
            box.center = CGPoint(x: 50, y: 150)
        }, group: group)
    })
})


UIView.animate(withDuration: 5, animations: {
    view.backgroundColor = .purple
}, group: group)


group.notify(queue: .main) {
    print("Animations complete!!")
}
