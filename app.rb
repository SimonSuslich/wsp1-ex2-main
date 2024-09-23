class App < Sinatra::Base

    # Funktion som returnerar en databaskoppling
    # Exempel på användning: db.execute('SELECT * FROM fruits')
    def db
        return @db if @db

        @db = SQLite3::Database.new("db/fruits.sqlite")
        @db.results_as_hash = true

        return @db
    end
    
    # Routen gör en redirect till '/fruits'
    get '/' do
        redirect('/fruits')
    end

    #Routen hämtar alla frukter i databasen
    get '/fruits' do
        @fruits = db.execute('SELECT * FROM fruits ORDER BY id')
        erb(:"fruits/index")
    end

    # Övning no. 2.1
    # Routen visar ett formulär för att spara en ny frukt till databasen.
    get '/fruits/new' do 
        erb(:"fruits/new")
    end

    # Övning no. 2.2
    # Routen sparar en frukt till databasen och gör en redirect till '/fruits'.
    post '/fruits' do 
        p params
        #todo
    end

    # Övning no. 1
    # Routen visar en frukt.
    get '/fruits/:id_num' do | id_num |
      
        @fruit = db.execute('SELECT * FROM fruits WHERE id=?', id_num).first
   
        # @beskrivning = db.execute('SELECT description FROM fruits WHERE id==id')
        erb(:"fruits/show")
    end

    post '/fruits/:id/delete' do | id |
        #todo: ta bort frukten med idt
        db.execute('DELETE FROM fruits WHERE id = ?', id)
        redirect("/fruits")        
    end
        

    get '/fruits/new' do

        erb(:"fruits/new")
    end

    post '/fruits' do | name, tastiness, description |
        # Spara fruit_name & fruit_description till variabler 
        # name & description
        name = fruit_name
        tastiness = fruit_tastiness
        description = fruit_description
    
    # SQL Insert
        db.execute("INSERT INTO fruits (name, tastiness,description) VALUES(?,?,?)", [name, tastiness,description])
    
    # Redirect
        redirect("/fruits")
        
    end

end