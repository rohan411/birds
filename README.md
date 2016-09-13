# Birds

A rails application for creating and listing birds. 


## Prerequisite  

*Rails > 4*  

*Ruby > 2*  

*Redis*

*MongoDb*  


## Steps to run
* enter database config in mongoid.yml, default address is localhost:27017
* run **bundle install**
* run **rake db:mongoid:create_indexes**
* run **rails server**

## Request Urls 

GET       **localhost:3000/birds**        To get all the visible birds in the database

POST      **localhost:3000/birds**        To create a new bird in the database

GET       **localhost:3000/birds/:id**    To get a bird's detail

DELETE    **localhost:3000/birds/:id**    To delete a bird
