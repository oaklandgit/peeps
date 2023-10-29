import ArgumentParser
import SwiftyContacts

@main
struct Peeps: ParsableCommand {
    @Argument(help: "Search for person to peep.")
    public var input: String

    public func run() throws {
        let contacts = try fetchContacts(matchingName: self.input)
        for (index, contact) in contacts.enumerated() {
            print("\(index + 1). \(contact.givenName) \(contact.familyName)")
            print("\(contact.identifier)")
            // print(contact)
        }

    }
}

