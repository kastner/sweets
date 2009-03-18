# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sweets_session',
  :secret      => '57a7b23a2a57fdb7504bd4d5add7e695828b67f3b5c85c22e16ec483cf9aaa8d53c3d0548fd0633172920c401f54e6362cdd94a0d7578f623257f9a9e5c33058'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
