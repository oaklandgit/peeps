import ArgumentParser
import SwiftyContacts

@main
struct Peeps: ParsableCommand {
    @Argument(help: "Search for person to peep.")
    public var input: String

    // @Flag(name: .shortAndLong, help: "Include phone numbers.")
    // public var phones: Bool = false

    // @Flag(name: .shortAndLong, help: "Include email addresses.")
    // public var emails: Bool = false

    public func run() throws {
        let contacts = try fetchContacts(matchingName: self.input)

        if contacts.count == 0 {
            print("No contacts found.")
            return
        }

        if contacts.count == 1 {
            print("Found 1 peep.\n")
            printContactCard(item: contacts[0])
            return
        } else {
            print("Found \(contacts.count) peeps.\n")
            
            for (index, contact) in contacts.enumerated() {
                printItem(item: contact, index: index + 1)
            }
            
            print("\nWho to peep? (1-\(contacts.count)): ", terminator: "")
            let selection = Int(readLine() ?? "0") ?? 0

            if selection > 0 && selection <= contacts.count {
                print()
                printContactCard(item: contacts[selection - 1])
            } else {
                print("No such peep.")
            }
            return
        }

    }
}

func printItem(item: CNContact, index: Int) -> Void {
    let paddedIndex = String(index).padding(toLength: 2, withPad: " ", startingAt: 0)
    print("\(paddedIndex) \(item.givenName) \(item.familyName)")
}

func printContactCard(item: CNContact) -> Void {
    print("\(item.givenName) \(item.familyName)")

        for phone in item.phoneNumbers {
            if let label = phone.label {
                let humanReadableLabel = getHumanReadableLabel(for: label)
                print("- \(humanReadableLabel): \(phone.value.stringValue)")
            }
        }
}

func getHumanReadableLabel(for label: String) -> String {
    let labelDict: [String: String] = [
        CNLabelPhoneNumberMain: "Main",
        CNLabelPhoneNumberMobile: "Mobile",
        CNLabelPhoneNumberiPhone: "iPhone",
    ]
    return labelDict[label] ?? "Other"
}

