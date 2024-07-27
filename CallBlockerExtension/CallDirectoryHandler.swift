import Foundation
import CallKit

class CallDirectoryHandler: CXCallDirectoryProvider {
    
    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        if context.isIncremental {
            // Provide incremental blocking or identification data.
            // Perform updates as needed.
        } else {
            // Provide the full set of blocking or identification data.
            addAllBlockingPhoneNumbers(to: context)
        }
        
        context.completeRequest()
    }
    
    private func addAllBlockingPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
        let patterns = ["0343", "0345"]
        
        // Generate numbers to block based on patterns
        let blockedNumbers = generateBlockedNumbers(from: patterns)
        
        for number in blockedNumbers {
            context.addBlockingEntry(withNextSequentialPhoneNumber: number)
        }
    }
    
    private func generateBlockedNumbers(from patterns: [String]) -> [CXCallDirectoryPhoneNumber] {
        var blockedNumbers: [CXCallDirectoryPhoneNumber] = []
        
        // Assuming you want to block the full 10-digit numbers starting with the given patterns
        for pattern in patterns {
            let base = pattern + "0000000"
            if let baseNumber = Int64(base) {
                for i in 0..<10000000 {
                    blockedNumbers.append(baseNumber + Int64(i))
                }
            }
        }
        
        return blockedNumbers
    }
}
