class ZohoSubscription

  def initialize(params)
    @params = params
    # @client_token = client_token
    # @client_id = client_id
    @refresh_token = @params[:refresh_token]
    # @access_token = get_access_token
    @code = create_code
    
  end

  def create_code
    '1000.a72aefc13d2195bc69095c15165668c6.e10a0ee51392b77c8bfcd57f25a7649d'
  end

  def create_access_token
    '1000.efd0a30f2a064e9bd060e497cc5ffbe4.721a3358fea351183c687e2b4daeece8'
  end

  def get_access_token
      zoho_token_details = ZohoToken.first
      time_diff = (Time.current - zoho_token_details.updated_at).to_i

      # if time_diff > zoho_token_details.token_expires_in.to_i  #Correct one
      if time_diff < zoho_token_details.token_expires_in.to_i
        puts "expired............"
        begin
          new_token_response = RestClient.post("https://accounts.zoho.com/oauth/v2/token", {:refresh_token => "1000.1f60701ed10cd9e4218ce6269fac16d2.9e36c2a7b3f94bb542d5073b9d542d59", :client_id => "1000.7JII82RGSEMA3RSUCOXA4RZL6PM4BE", :client_secret => "a54e2c40317f8a3f211df6b5697b19f91f3ca04198", :redirect_uri => "http://www.zoho.com/subscriptions", :grant_type => "refresh_token"})
        rescue StandardError => e
        end

        if new_token_response
          new_token = JSON.parse(new_token_response.body)
        end

        zoho_token_details.access_token = new_token['access_token']
        zoho_token_details.token_expires_in = new_token['expires_in']

        if zoho_token_details.valid?
          zoho_token_details.save
        end
      else
        puts "Not expired.........."
        new_token = zoho_token_details.access_token
      end
      # binding.pry
      return new_token
  end

  def get_hostedpages_details
    # Function to call access token
    @access_token = get_access_token

    # binding.pry

    if @access_token['access_token']
      hostedpage_id = @params[:hostedpages_id]

      begin
        hostedpages_response = RestClient.get("https://subscriptions.zoho.com/api/v1/hostedpages/#{hostedpage_id}", {:Authorization => "Zoho-oauthtoken #{@access_token}"})
      rescue StandardError => e
      end

      # binding.pry
      if hostedpages_response
        hostedpages_data = JSON.parse(hostedpages_response.body)
      end
      return hostedpages_data
    else
      return nil
    end
  end

  def get_hostedpages_data
    binding.pry
  end



end