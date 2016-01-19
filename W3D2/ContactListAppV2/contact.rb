require 'pg'

# Represents a person in an address book.
class Contact

  attr_accessor :name, :email, :id

  def initialize(name, email, id)
    # TODO: Assign parameter values to instance variables.
    @name = name 
    @email = email
    @id = id
  end

  # Provides functionality for managing a list of Contacts in a database.
  class << self

    # Returns an Array of Contacts loaded from the database.
    def all
      conn = connection
      contacts = []
      conn.exec_params('select * from contacts;') do |results|
        results.each do |contact|
          contacts.push(Contact.new(contact["name"],contact["email"],contact["id"]))
        end 
      end 
      conn.close
      contacts
    end 


    # Creates a new contact, adding it to the database, returning the new contact.
    def create(name, email)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      conn = connection
      conn.exec_params("insert into contacts (name, email) values ($1 , $2 )", [name, email])
      conn.close
    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      conn = connection
      contacts = []
      conn.exec_params("select * from contacts where id = $1::int;", [id]) do |results|
        results.each do |contact|
          contacts.push(Contact.new(contact["name"],contact["email"],contact["id"]))
        end 
      end 
      conn.close
      contacts
    end

    # Returns an array of contacts who match the given term.
    def search(term)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      conn = connection
      contacts = []
      conn.exec_params("select * from contacts where name like $1 or email like $1;", ['%'+term+'%']) do |results|
        results.each do |contact|
          contacts.push(Contact.new(contact["name"],contact["email"],contact["id"]))
        end 
      end 
      conn.close
      contacts
    end

    def save(id, name, email)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      conn = connection
      conn.exec_params("update contacts set name = $2, email = $3 where id = $1::int;", [id, name, email]) 
      conn.close
    end

    def destroy(id)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      conn = connection
      conn.exec_params("delete from contacts where id = $1::int;", [id]) 
      conn.close
    end


    def connection
      conn = PG.connect(
        host: 'localhost',
        dbname: 'contact_list',
        user: 'development',
        password: 'development'
        )
    end 

  end

end
