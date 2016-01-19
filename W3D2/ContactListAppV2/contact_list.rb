require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  if ARGV.empty?
    puts "Here is a list of available commands:"
    puts "new - Create a new contact"
    puts "list - List all contacts"
    puts "show - Show a contact"
    puts "search - Search contacts"
    puts "update - Update contact"
    puts "destroy - Delete contact"
  end 

  if ARGV.first == "list"
    contacts = Contact.all
    contacts.each{|contact| puts "#{contact.id}: #{contact.name} (#{contact.email})"}
    puts "#{contacts.length} records total"
  end

  if ARGV.first == "new"
    puts "What's your contact name?"
    name = STDIN.gets.chomp.to_s
    puts "What's your contact email?"
    email =  STDIN.gets.chomp.to_s
    Contact.create(name,email)
  end

  if ARGV.first == "show"
    contact = Contact.find(ARGV[1])
    if contact.empty? 
      puts "Ops!!!!! Contact not found"
    else
      puts "Id: #{contact[0].id}"
      puts "Name: #{contact[0].name}"
      puts "Email: #{contact[0].email}"
    end
  end

  if ARGV.first == "search"
    contacts = []
    contacts = Contact.search(ARGV[1].to_s)

    if contacts.empty? 
      puts "Ops!!!!! Contact not found"
    else
      contacts.each{ |contact|
      puts "Id: #{contact.id}"
      puts "Name: #{contact.name}"
      puts "Email: #{contact.email}"
    }
    end
  
  end 

  if ARGV.first == "update"
      contacts = []
      contacts = Contact.find(ARGV[1].to_s)

      if contacts.empty? 
        puts "Ops!!!!! Contact not found"
      else
        contacts.each{ |contact|
        puts "Id: #{contact.id}"
        puts "Name: #{contact.name}"
        puts "Email: #{contact.email}"
        }
        id = ARGV[1].to_s
        puts "What's your new contact name?"
        name = STDIN.gets.chomp.to_s
        puts "What's your new contact email?"
        email =  STDIN.gets.chomp.to_s
        Contact.save(id,name,email)
      end
    
  end 

  if ARGV.first == "destroy"
    Contact.destroy(ARGV[1].to_s)
  end

end

test = ContactList.new
