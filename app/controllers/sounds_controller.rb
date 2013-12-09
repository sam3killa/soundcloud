class SoundsController < ApplicationController

require 'soundcloud'

	def index
		# @client = SoundCloud.new(:client_id => '8e38e03320f1b0cdde7d69fe832142c9')
		# # get 10 hottest tracks
		# @tracks = @client.get('/tracks', :limit => 10, :order => 'hotness')
		# # print each link

		client = SoundCloud.new({
		  :client_id     => '8e38e03320f1b0cdde7d69fe832142c9',
		  :client_secret => 'b357b32aeb0292c403a4652da0d60214',
		  :redirect_uri  => 'http://localhost:3000/login_done',
		})

		redirect_to client.authorize_url()
		# the user should be redirected to "https://soundcloud.com/connect?client_id=YOUR_CLIENT_ID&response_type=code&redirect_uri=YOUR_REDIRECT_URI"
		# after granting access he will be redirected back to YOUR_REDIRECT_URI
		# in your respective handler you can build an exchange token from the transmitted code
	end

	def login_done
		redirect_to sounds_path	
	end

	def create
	end

	def sounds
		# create a client object with your app credentials
		@client = Soundcloud.new(:client_id => '8e38e03320f1b0cdde7d69fe832142c9')

		# get a tracks oembed data
		@track_url = 'http://soundcloud.com/forss/flickermood'
		@embed_info = @client.get('/oembed', :url => @track_url)

		@client = Soundcloud.new(:client_id => '8e38e03320f1b0cdde7d69fe832142c9')

		if params[:q].present?
			@tracks = @client.get('/tracks', :q => 'blah', :licence => 'cc-by-sa', :filter => 'downloadable', :limit => 5)
		else
			@tracks = @client.get('/tracks', :q => 'hello', :licence => 'cc-by-sa', :filter => 'downloadable', :limit => 5)
		end

		# # create a client object with your app credentials

		# # find all sounds of buskers licensed under 'creative commons share alike'
		
		@track_info
	end
end
