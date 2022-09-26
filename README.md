### Test Description: 
Our company employs craftsmen teams for installing solar panels on rooftops of its customers in
Germany. Each team has its own base city, specified by the pair of latitude/longitude
coordinates. Each team has a certain level of skills, implying that some teams are faster in
doing their job than the others(skill level 1 – unlimited number of panels that can be installed
per day, skill level 2 – exactly 22 panels per day, and skill level 3 – less than 22 panels per day).
Also, different teams are available for work at different periods of time.

Households that ordered solar panel installation are defined by their latitude/longitude
coordinates as well as the number of solar panels to install on the roof and the date when the
installation process should begin.

### The task is to find the nearest (according to the accurate distance) customer for each craftsmen team, so that (a) a given team is available for work when a customer has time, and (b) this team has necessary skill level to accomplish all work in one day.


### Task 
1: Create 3 tables and populate them with real data in SQL statements:
        1. Bases (teamid, latitude, longitude); let us assume there are only 3 base cities.
        2. Teams (team id, availability from, availability till, skill level); let us assume that there are 5 teams, and team id ranges from 1 to 5.
        3. Customers (customer id, latitude, longitude, no. of panels to install, start date for installation); let us assume there are 15 customers, and customer id ranges from 1 to 15.

keep in mind that the third table does not have a common column with other two tables Your output can look like:
team 1 -> customer 10
team 2 -> customer 7
team 3 -> customer 5
team 4 -> customer 3
team 5 -> customer 12