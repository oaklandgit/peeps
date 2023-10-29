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
    public var phoneNumbers: Bool = false

    @Flag(name: .shortAndLong, help: "Include email addresses.")
    public var emailAddresses: Bool = false

    public func run() throws {
        let contacts = try fetchContacts(matchingName: self.input)
        for contact in contacts {
            
            let fullName = "\(contact.givenName) \(contact.familyName)"
            let dividerLine = String(repeating: "=", count: fullName.count)
            print("\u{f4ff} \(fullName)")
            print("==\(dividerLine)")
            if self.phoneNumbers {
                for phone in contact.phoneNumbers {
                    if let label = phone.label {
                        let humanReadableLabel = getHumanReadableLabel(for: label)
                        print("\u{f095} \(humanReadableLabel): \(phone.value.stringValue)")
                    }
                }
            }
            print("\n")

        }
        

    }
}

