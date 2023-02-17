import Foundation

protocol ViewCoding: AnyObject {
    func setupView()
    func setupHierarchy()
    func setupConstraints()
}

extension ViewCoding {
    func setupView() {}
    
    func buildLayout() {
        setupView()
        setupHierarchy()
        setupConstraints()
    }
}
