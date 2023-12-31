import ArgumentParser
import SwiftyContacts

let labelIndent = 6
let indentSpaces = String(repeating: " ", count: labelIndent)

@main
struct Peeps: ParsableCommand {
    @Argument(help: "Search for person to peep.")
    public var input: String

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
    print(String(repeating: "-", count: item.givenName.count + item.familyName.count + 1))
    printPhoneNumbers(phoneNumbers: item.phoneNumbers)
    print()
    printEmailAddresses(emailAddresses: item.emailAddresses)
    print()
    printPostalAddresses(postalAddresses: item.postalAddresses)
}

func printPhoneNumbers(phoneNumbers: [CNLabeledValue<CNPhoneNumber>]) -> Void {
    for phone in phoneNumbers {
        if let label = phone.label {
            let humanReadableLabel = getHumanReadableLabel(for: label)
            print("\(humanReadableLabel) \(phone.value.stringValue)")
        }
    }
}

func printEmailAddresses(emailAddresses: [CNLabeledValue<NSString>]) -> Void {
    for email in emailAddresses {
        if let label = email.label {
            let humanReadableLabel = getHumanReadableLabel(for: label)
            print("\(humanReadableLabel) \(email.value)")
        }
    }
}

func printPostalAddresses(postalAddresses: [CNLabeledValue<CNPostalAddress>]) -> Void {
    for address in postalAddresses {
        if let label = address.label {
            let humanReadableLabel = getHumanReadableLabel(for: label)
            print("\(humanReadableLabel) \(address.value.street) \(address.value.subLocality)")
            print("\(indentSpaces) \(address.value.city) \(address.value.state) \(address.value.postalCode)")
        }
    }
}

func getHumanReadableLabel(for label: String) -> String {
    let labelDict: [String: String] = [
        CNLabelPhoneNumberMain: "Main",
        CNLabelPhoneNumberMobile: "Mobile",
        CNLabelPhoneNumberiPhone: "iPhone",
        CNLabelHome: "Home",
        CNLabelWork: "Work",
        CNLabelOther: "Other",
    ]

    let paddedLabel = (labelDict[label] ?? "Other").padding(toLength: labelIndent, withPad: " ", startingAt: 0)
    return paddedLabel
}

