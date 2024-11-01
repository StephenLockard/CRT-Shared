System.debug('Hello, this is a sample log message from Copado!');
System.debug('Current date and time: ' + DateTime.now());
List sampleList = new List{'Apple', 'Banana', 'Cherry'};
System.debug('Sample list contents: ' + sampleList);
System.debug('Number of SOQL queries used: ' + Limits.getQueries() + ' out of ' + Limits.getLimitQueries());
System.debug('Sample logging complete.');