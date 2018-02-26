# README

Search Engine:

Search Engine is a web application built on Ruby using Rails and Bootstrap. It takes in 3 static JSON files as input. The static files are details about Users, Tickets and Organizations. The application parses the JSON files. The user can enter a search term under any of the 3 search parameters mentioned, using any search field for each parameter. Upon searching for a term, search results are displayed based on the parsed JSON files. The user can click on the search results and a modal will be displayed, holding the entire User/Ticket/Organization details.




GEM versions used:

* Ruby version - 2.4.1p111

* Rails version - 5.1.5

* RVM version - 1.29.3

* RSpec version - 3.7
 
* There are no databases used here.




Steps to Install and Run the application on OSX:

1. Go to your workspace, and execute the command - 'git clone https://github.com/Supritha-Amudhu/search_engine.git'
2. cd into search_engine.
3. Create a gemset with the above mentioned Ruby and Rails version using - '$ rvm gemset create <gemset name>'
4. Run 'bundle install'
5. Run the command - 'rails server' to start the server.
6. Open the URL - 'http://localhost:3000/' - This will display the Home Page of the application.




Steps to run RSpec:

1. Open a new tab in your terminal.
2. Run the command - 'rake spec' to execute all the defined test cases.



