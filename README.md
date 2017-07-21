Synopsis
Mecha Closed Won, or Mecha for short, reads "Order Notifcation" emails, indicating that a client has paid and devices will now be shipped to said client, that come into a specific email in box and mark the corresponding Oppurtunity "Closed Won" in the indicated Salesforce.com instance. 

Motivation
Carmine Customer Support closes, marks "Closed Won", by hand when they see the "Order Notification" email comes into the order@carmine.io inbox. This can be done automatically. 

Install 
Use ruby 2.2.1. Add the proper IMAP info to mail.rb and Salesforce API credentials to api.rb. Some variables will need to be changed in mecha.rb most importantly the report ID in the url in the "report" variable value that indicates what report mecha.rb is accessing. 

Tests
To test that the email inbox and Salesforce API are working using mailtest.rb and sfdctest.rb. 

License
All properties belong to Ryan Skidmore. ryan.skidmore@yahoo.com. +19492664664

    .__________________________.
    | .___________________. |==|
    | |     Apple ][      | |  |
    | |                   | |  |
    | |                   | |  |
    | |     EMULATOR      | |  |
    | |       =)          | |  |
    | | LIVE, GROW, HACK  | |  |
    | | ]                 | | ,|
    | !___________________! |(c|
    !_______________________!__!
    |    ___ -=      ___ -= | ,|
    | ---[_]---   ---[_]--- |(c|

    !_______________________!__!
   /                            \
  /  [][][][][][][][][][][][][]  \
 /  [][][][][][][][][][][][][][]  \
(  [][][][][____________][][][][]  )
 \ ------------------------------ /
  \______________________________/
