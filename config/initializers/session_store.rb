# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_qwiki2_session',
  :secret      => 'c050bbf0107b2feda9484b5c39a4d55b81c072a3f9b3848b69c318cea4d2dbf33cd8d33f8d1225754b95d5039beb624ff8aaf8e7c4b45a62fc47e3ac0ac0f999'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
