# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_recipewiki_session',
  :secret      => '04c9999bbbc5376c4defc4469a922561c0640d564ce40ccacd95868b08f5ed2f72f9a19469dc4fae20660b4f89420249c79c20fae49655cd921fd5e5c858d726'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
