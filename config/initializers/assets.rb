# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.woff *.woff2)

# ------------------ CSS ---------------------

Rails.application.config.assets.precompile += %w( balloon.css )
Rails.application.config.assets.precompile += %w( bootstrap-tour/bootstrap-tour.css )

Rails.application.config.assets.precompile += %w( idr_reports_style.scss )
Rails.application.config.assets.precompile += %w( ipolo-order.scss )
Rails.application.config.assets.precompile += %w( create.scss )


# --------------- javascript -----------------

Rails.application.config.assets.precompile += %w( async.js )
Rails.application.config.assets.precompile += %w( create_stuff.js )
Rails.application.config.assets.precompile += %w( create_guide.js )

Rails.application.config.assets.precompile += %w( bootstrap-tour/bootstrap-tour.js )