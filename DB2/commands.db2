
-Commands for DB2i - Interactive commands

-DIS DATABASE(<DBNAME>) SPACENAM(<SPACENAME>) 

# Gives status of Database and if spacenam is specified for a specific space
generally used to know if the DB is in rw mode or any other

# spacenam can be either tablespace name or indexspace name

# avoid spacenam to know the status of all spaces in DB

# Use additional keyword RESTRICT to know the space in restricted mode



-START DATABSE(DBNAME) SPACENAME(<SPACENAME>)

# To start a database , use optional parameters to start in a specific mode


-DIS UTIL(<UTIL-ID>)
-TERM UTIL(<UTIL-ID>)

# Used to ge the Utility id and to terminates
# extremely useful when we have a Load Utility Job failure abnormally



