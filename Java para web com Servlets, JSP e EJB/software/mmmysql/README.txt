MM.MySQL 2.0.8
Mark Matthews JDBC Driver for MySQL
Copyright (c) 1998-2001 Mark Matthews

CONTENTS

* License
* System Requirements
* Introduction
* Usage and Installation
* Troubleshooting
* Known Bugs
* Support

LICENSE

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Library General Public
License as published by the Free Software Foundation; either
version 2 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Library General Public License for more details.
 
You should have received a copy of the GNU Library General Public
License along with this library; if not, write to the
Free Software Foundation, Inc., 59 Temple Place - Suite 330,
Boston, MA  02111-1307, USA.

See the COPYING file located in the top-level-directory of
the archive of this library for complete text of license.

SYSTEM REQUIREMENTS
 
* Any Java virtual machine supporting JDBC-1.2 or JDBC-2.0 (JDK-1.1 or higher)
* Any MySQL server supporting version 9 or 10 of the MySQL protocol

Because MySQL is not fully ANSI SQL-92 compliant, it is not possible to 
create a fully JDBC-compliant driver for MySQL.  However, this driver 
strives to implement as much of the JDBC API as is feasible.

INTRODUCTION

MM.MySQL is an implemntation of the JDBC API for the MySQL relational
database server. It strives to conform as much as possible to the API
as specified by JavaSoft. It is known to work with many third-party 
products, including Borland JBuilder, IBM Visual Age for Java, SQL/J,
the Locomotive and Symantec Visual Cafe.

USAGE AND INSTALLATION

MM.MySQL is distributed as a .jar archive containing the sources 
and class files as well as a class-file only "binary" .jar archive 
named "mysql-2.0.8-bin.jar".

You will need to use the "jar" command-line utility that comes with your JDK 
to un-archive the distribution.

Once you have un-archived the distribution .jar archive,
you can install the driver in one of two ways:

Either copy the org subdirectory and all of it's contents
to anywhere you like, and put the directory holding the org subdirectory
in your classpath, or...

Put mysql-2.0.8-bin.jar in your classpath, either by adding the 
FULL path to it to your CLASSPATH enviornment variable, or putting it
in $JAVA_HOME/jre/lib/ext.

If you are using a servlet engine or application server, you will have
to read your vendor's documentation for more information on how to
configure third-party class libraries, as most application servers
ignore the CLASSPATH environment variable. If you are developing
servlets and/or JSPs, and your application server is J2EE-compliant, 
you should put the driver's .jar file in the WEB-INF/lib subdirectory
of your webapp, as this is the standard location for third party 
class libraries in J2EE web applications. You can also use the
org.gjt.mm.mysql.MySQLDataSource class which implements both XADataSource and
ConnectionPoolDataSource, if your J2EE application server supports/requires
them. MysqlDataSource supports the following parameters (through standard "set"
mutators):

	user
	password
	serverName
	databaseName
	port

If you are going to use the driver with the JDBC DriverManager, you would use
"org.gjt.mm.mysql.Driver" as the class that implements java.sql.Driver.

You might use this name in the Class.forName() call, for example.

To connect to the database, you need to use a JDBC url with the following 
format ([xxx] denotes optional url components):

  jdbc:mysql://[hostname][:port]/[dbname][?param1=value1][&param2=value2].....

URL Parameters (can be passed as properties in 
DriverManager.getConnection() as well):

------------------------------------------------------------------------------
Name 			Use 					Default Value 
------------------------------------------------------------------------------
user 			The user to connect as 			none 

password 		The password to use when connecting 	none 

autoReconnect 	        should the driver attempt to            false
                        re-connect if the connection dies? 
                        (true/false) 		

maxReconnects 	        if autoReconnect is enabled, how many   3
			times should the driver attemt to 
			reconnect? 	 

initialTimeout 	        if autoReconnect is enabled, the        2
                        initial	time to wait between 
                        re-connect attempts (seconds) 					

maxRows 		The maximum number of rows to return 	0
			(0 means return all rows) 			 

useUnicode 		should the driver use Unicode character false 
			encodings when handling 
			strings? (true/false) 	
			
characterEncoding       if useUnicode is true, what character   none
			encoding should the driver use when 
			dealing with strings? 				

relaxAutocommit	        if the version of MySQL the driver      false
			connects to does not support 
			transactions, allow calls to commit, 
			rollback and setAutoCommit? (true/false)	

ultraDevHack	        Create PreparedStatements for 		false
			prepareCall(), because UltraDev 
			is broken? (true/false)
			
capitalizeTypeNames     Capitalize type names in 		false
			DatabaseMetaData? (usually only
			usefull when using WebObjects)

			
A simple connection example looks like:

	Class.forName("org.gjt.mm.mysql.Driver").newInstance();
	
	java.sql.Connection conn;
	
	conn = DriverManager.getConnection(
		"jdbc:mysql://localhost/test?user=blah&password=blah");
	
If you need further JDBC tutorial information, please see
http://www.java.sun.com/products/jdbc/

The driver supports batch updates for Statements and PreparedStatements.
Batch updates will be processed in entirety, if any of the updates raise a
SQLException, a java.sql.BatchUpdateException will be thrown after all updates
have been processed, with update count values of '-3' for any statements that
were not completed (see section 6.1 in the JDBC-2.1 API spec for more details).

TROUBLESHOOTING

There are a few issues that seem to be encountered often by users of MM.MySQL. 
This section deals with their symptoms, and their resolutions. If you have
further issues, see the "SUPPORT" section below.

  Issue: 

  "When I try to connect to the database with MM.MySQL, I get the
  following exception:

  SQLException: Server configuration denies access to data source
  SQLState: 08001
  VendorError: 0

  What's going on? I can connect with the MySQL client."

  Resolution: 

  MM.MySQL must use TCP/IP sockets to connect to MySQL, as 
  Java does not support Unix Domain Sockets. Therefore, when MM.MySQL
  connects to MySQL, the security manager in MySQL server will use the
  HOSTS table to determine whether or not the connection should be allowed.

  You must add grants to allow this to happen. The following is an example
  of how to do this (but not the most secure).

  From the mysql command-line client, issue the following command

  "GRANT ALL PRIVILEGES ON [dbname].* to [user]@[hostname] identified by 
  '[password]'"

  replacing [dbname] with the name of your database, [user] with the username,
  [hostname] with the host that MM.MySQL will be connecting from, and [password]
  with the password you want to use. Be aware that RedHat linux is broken with
  respect to the hostname portion for the case when you are connecting from 
  localhost. You need to use "localhost.localdomain" for the [hostname] value 
  in this case.

  Follow this by issuing the "FLUSH PRIVILEGES" command.

  I suggest you read the permissions/security section of your MySQL server 
  manual for a much more detailed explanation of how this works.
  
  ----

  Issue: 

  "My application throws a SQLException 'No Suitable Driver'".

  Resolution: 

  One of two things are happening. Either the driver is not in
  your CLASSPATH (see the "USAGE AND INSTALLATION" section above), or your
  URL format is incoorect (once again see "USAGE AND INSTALLATION").

  ----

  Issue: 

  "I'm trying to use MM.MySQL in an applet and I get the following
  exception: 
  
  SQLException: Cannot connect to MySQL server on host:3306. Is there 
  a MySQL server running on the machine/port you are trying to connect to? 
  (java.security.AccessControlException) 
  SQLState:     08S01 
  VendorError:  0 
  
  What's wrong?"

  Resolution:
  
  Applets can only make network connections back to the machine that the
  webserver that served the .class files for the applet. This means that
  mysql must run on the same machine (or you must have some sort of port
  re-direction) for this to work. This also means that you will not be
  able to test applets from your local filesystem, you must always deploy
  them to a webserver.

  ----

  Issue: 

  "I have a servlet/application that works fine for a day, and then stops 
  working overnight".

  Resolution: 

  MySQL closes connections after 8 hours of inactivity. You either
  need to use a connection pool that handles stale connections or use the 
  "autoReconnect" parameter (see "USAGE AND INSTALLATION"). Also, you should
  be catching SQLExceptions in your application and dealing with them, rather
  than propagating them all the way until your application exits, this is just
  good software development. MM.MySQL will set the SQLState (see 
  java.sql.SQLException.getSQLState() in your APIDOCS) to "08S01" when it 
  encounters network-connectivity issues during the processing of a query. 
  Your application code should then attempt to re-connect to MySQL at this 
  point.

  ----

  Issue:

  "I'm trying to use JDBC-2.0 updatable result sets, and I get an exception
  saying my result set is not updatable..."

  Resolution:

  Because MySQL does not have row identifiers, MM.MySQL can only update
  result sets that have come from queries that select the primary key(s) and
  only span one table (i.e. no joins). This is outlined in the JDBC specification.


KNOWN BUGS

There are some parts of the JDBC-2.0 spec that are not implemented (yet). 

If you see something that is not implemented, and you have an idea on how to
do it, go ahead and let me know. I'm always looking for help and/or feedback
about the driver.

SUPPORT

Commercial support (with various levels of guaranteed service) is available 
from my employer, The Net Squad. Contact sales@thenetsquad.com for more 
information or see http://www.thenetsquad.com/services/jdbcsupport.html 
for further information.

Otherwise community-based support is available on the mysql-java mailing list 
available from www.mysql.com, or through e-mail to me <mmatthew@thematthews.org>. 

--
This software is OSI Certified Open Source Software.
OSI Certified is a certification mark of the Open Source Initiative.
