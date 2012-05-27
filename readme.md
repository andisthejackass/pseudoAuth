pseudoAuth
==========

**pseudoAuth** is a simple Ruby-based implementation of a pseudonymous authentication scheme between a client and a server. Using hashes, public and private key encryption and random challenge-response, a user is authenticated to the server, without actually revealing the real username.

Requirements
------------
In order to run **pseudoAuth** you need to have Ruby installed (I recommend v1.9.2). Other than that, some gems are required, too. You can install them like this:
    gem install activerecord
    gem install activesupport
    gem install i18n
    gem install activemodel
    gem install arel
    gem install multi_json
    gem install sqlite3

Deploy
------
In order to run, open two terminals. First run
    ruby server.rb
and then
    ruby client.rb
and you'll see some messages showing. That's it! ;)
