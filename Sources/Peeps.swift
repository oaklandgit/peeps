import ArgumentParser
import SwiftyContacts

func getHumanReadableLabel(for label: String) -> String {
    let labelDict: [String: String] = [
        CNLabelPhoneNumberMain: "Main",
        CNLabelPhoneNumberMobile: "Mobile",
        CNLabelPhoneNumberiPhone: "iPhone",
    ]
    return labelDict[label] ?? "Other"
}

@main
struct Peeps: ParsableCommand {
    @Argument(help: "Search for person to peep.")
    public var input: String

    @Flag(name: .shortAndLong, help: "Include phone numbers.")
    public var phones: Bool = false

    @Flag(name: .shortAndLong, help: "Include email addresses.")
    public var emails: Bool = false

    public func run() throws {
        let contacts = try fetchContacts(matchingName: self.input)
        for (index, contact) in contacts.enumerated() {
            
            let fullName = "\(contact.givenName) \(contact.familyName)"
            let dividerLine = String(repeating: "=", count: fullName.count)
            print("\(index + 1). \(fullName)")
            
            if self.phones {
                // print("==\(dividerLine)")
                for phone in contact.phoneNumbers {
                    if let label = phone.label {
                        let humanReadableLabel = getHumanReadableLabel(for: label)
                        print("\u{f095} \(humanReadableLabel): \(phone.value.stringValue)")
                    }
                }
            }
            // print("\n")

        }
        

    }
}

