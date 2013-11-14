# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
OurgoodsSplash::Application.config.secret_key_base = ENV['SECRET_KEY_BASE'] || '423b7172dcd2a216dc52fe46f13d618d66c79129f256afd81d6b31fb68ca526a005576a36e9ce4d110666667e2ca404ae760bbe04511d14020cde2fbee09e261'
