import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [PatioItem] = []
    @Published var isPro: Bool = false

    /// Free-tier cap. Deliberately kept above the seed count so a fresh
    /// install never trips the paywall on first launch.
    static let freeLimit = 10

    private let fileURL: URL

    init() {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("Patiowatch", isDirectory: true)
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        fileURL = dir.appendingPathComponent("items.json")
        load()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([PatioItem].self, from: data) else {
            items = [
        PatioItem(itemName: "Sample Item 1", lastCleaned: Date().addingTimeInterval(-604800), stored: true),
        PatioItem(itemName: "Sample Item 2", lastCleaned: Date().addingTimeInterval(-1209600), stored: false),
        PatioItem(itemName: "Sample Item 3", lastCleaned: Date().addingTimeInterval(-1814400), stored: true),
        PatioItem(itemName: "Sample Item 4", lastCleaned: Date().addingTimeInterval(-2419200), stored: false)
            ]
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    @discardableResult
    func add(_ item: PatioItem) -> Bool {
        guard canAddMore else { return false }
        items.insert(item, at: 0)
        save()
        return true
    }

    func update(_ item: PatioItem) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: PatioItem) {
        items.removeAll { $0.id == item.id }
        save()
    }
}
