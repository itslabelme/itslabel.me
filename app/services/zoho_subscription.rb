class ZohoSubscription

  def initialize(params)
    @params = params
    @refresh_token = @params[:refresh_token]
    # @client_token = client_token
    # @client_id = client_id
    # @access_token = get_access_token
    # @code = create_code
    
  end

  # Function to fetch hostedpage payload using access token and hostedpage id
  def fet_hostedpages_payload(access_token)

      if access_token
        hostedpage_id = @params[:hostedpages_id]

        puts "------- call initiated for payload ".yellow

        begin
          hostedpages_response = RestClient.get("https://subscriptions.zoho.com/api/v1/hostedpages/#{hostedpage_id}", {:Authorization => "Zoho-oauthtoken #{access_token}"})
        rescue StandardError => e
        end

        # binding.pry
        if hostedpages_response
          hostedpages_data = JSON.parse(hostedpages_response.body)
        end

        puts "------- got the payload ".yellow

        return hostedpages_data
      else
        puts "------- no access token while go for payload so payload fetching function not working ".yellow
        return nil
      end
  end

  def get_hostedpages_details

    puts "------- get_hostedpages_details function triggered ".blue

    zoho_token_details = ZohoToken.first
    time_diff = (Time.current - zoho_token_details.updated_at).to_i

    puts "------- time diff -  #{time_diff} ".blue

    # binding.pry 
    # Rails.application.secrets.zoho_client_id

    # Check the aceess token is expired or not. Normaly access token has 1 hrs of expiry.
    # Once its expired, fetch the access token using refresh token and save the same to our DB
    if time_diff > zoho_token_details.token_expires_in.to_i  

        puts "------- time diff is grater than token so go for create token ".green

        # Fetch Access token
        begin
          new_token_response = RestClient.post("https://accounts.zoho.com/oauth/v2/token", {:refresh_token => @refresh_token , :client_id => Rails.application.secrets.zoho_client_id, :client_secret => Rails.application.secrets.zoho_client_secret, :redirect_uri => Rails.application.secrets.zoho_redirect_uri, :grant_type => "refresh_token"})
        rescue StandardError => e
        end

        # Parse Json data
        if new_token_response
          new_token = JSON.parse(new_token_response.body)
        end

        puts "------- token created -  #{new_token['access_token']} ".green

        # Save Access token to DB
        zoho_token_details.access_token = new_token['access_token']
        zoho_token_details.token_expires_in = new_token['expires_in']
        if zoho_token_details.valid?
          zoho_token_details.save
        end

        puts "------- access token saved to DB ".green

        # Fetch Hosted page payload
        return fet_hostedpages_payload(new_token['access_token'])
    else
        puts "------- time diff is less than than token so token fetch from DB".red
        # Fetch Hosted page payload
        # access_token = zoho_token_details.access_token
      return fet_hostedpages_payload(zoho_token_details.access_token)
    end
  end


  # def get_access_token
  #     zoho_token_details = ZohoToken.first
  #     time_diff = (Time.current - zoho_token_details.updated_at).to_i

  #     # if time_diff > zoho_token_details.token_expires_in.to_i  #Correct one
  #     if time_diff < zoho_token_details.token_expires_in.to_i
  #       puts "expired............"
  #       begin
  #         new_token_response = RestClient.post("https://accounts.zoho.com/oauth/v2/token", {:refresh_token => "1000.1f60701ed10cd9e4218ce6269fac16d2.9e36c2a7b3f94bb542d5073b9d542d59", :client_id => "1000.7JII82RGSEMA3RSUCOXA4RZL6PM4BE", :client_secret => "a54e2c40317f8a3f211df6b5697b19f91f3ca04198", :redirect_uri => "http://www.zoho.com/subscriptions", :grant_type => "refresh_token"})
  #       rescue StandardError => e
  #       end

  #       if new_token_response
  #         new_token = JSON.parse(new_token_response.body)
  #       end

  #       zoho_token_details.access_token = new_token['access_token']
  #       zoho_token_details.token_expires_in = new_token['expires_in']
  #       if zoho_token_details.valid?
  #         zoho_token_details.save
  #       end

  #     else
  #       puts "Not expired.........."
  #       new_token = zoho_token_details.access_token
  #     end
  #     # binding.pry
  #     return new_token
  # end


end