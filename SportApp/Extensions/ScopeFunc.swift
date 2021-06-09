import Foundation

protocol ScopeFunc {}
extension ScopeFunc {
    @inline(__always) func apply(block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
    @inline(__always) func with<R>(block: (Self) -> R) -> R {
        block(self)
    }
}

extension NSObject: ScopeFunc {}
