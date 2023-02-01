require 'net/http'
class ZohoSubscription

  def initialize(params)
    @params = params
    @refresh_token = @params[:refresh_token]    
  end

  def check_token_expiry_fetch_tocken
    zoho_token_details = ZohoToken.first
    time_diff = (Time.current - zoho_token_details.updated_at).to_i
    if time_diff > zoho_token_details.token_expires_in.to_i  
        # Fetch Access token
        begin
          new_token_response = RestClient.post("https://accounts.zoho.com/oauth/v2/token", {:refresh_token => @refresh_token , :client_id => Rails.application.secrets.zoho_client_id, :client_secret => Rails.application.secrets.zoho_client_secret, :redirect_uri => Rails.application.secrets.zoho_redirect_uri, :grant_type => "refresh_token"})
        rescue StandardError => e
        end

        # Parse Json data
        if new_token_response
          new_token = JSON.parse(new_token_response.body)
        end

        # Save Access token to DB
        zoho_token_details.access_token = new_token['access_token']
        zoho_token_details.token_expires_in = new_token['expires_in']
        if zoho_token_details.valid?
          zoho_token_details.save
        end

        # Fetch Hosted page payload
        return new_token['access_token']
    else
        # Fetch Hosted page payload
      return zoho_token_details.access_token
    end

  end

  def fetch_subscription_hosted_data
    # Fetch access token - If time.now is larger than last update in data entry then create new token else fetch from DB
    access_token = check_token_expiry_fetch_tocken
    hostedpage_id = @params[:hostedpage_id]

    begin
       # Create the HTTP request
      uri = URI("https://subscriptions.zoho.com/api/v1/hostedpages/#{hostedpage_id}?organization_id=#{Rails.application.secrets.zoho_organization_id}")
      # binding.pry
      req = Net::HTTP::Get.new(uri)
      req["Content-Type"] = "application/json"
      req["Authorization"] = "Zoho-oauthtoken #{access_token}"
      # req.body = subscription_data.to_json

      # Send the request and get the response
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end

    rescue StandardError => e
    end

    # Parse the response
    hosted_data = JSON.parse(res.body)

    # Check if the subscription was created successfully
    if res.is_a?(Net::HTTPSuccess)
      puts "Successfully fetched subscription data"
      result_data = {status: true, message: "Success", data: hosted_data}
    else  
      puts "Failed to create subscription: #{hosted_data["message"]}"
      result_data = {status: false, message: hosted_data["message"], data: nil}
    end
  end

  # Function to fetch hostedpage payload using access token and hostedpage id
  def fetch_hostedpages_payload(access_token)

      if access_token
        hostedpage_id = @params[:hostedpages_id]

        begin
          hostedpages_response = RestClient.get("https://subscriptions.zoho.com/api/v1/hostedpages/#{hostedpage_id}", {:Authorization => "Zoho-oauthtoken #{access_token}"})
        rescue StandardError => e
        end

        if hostedpages_response
          hostedpages_data = JSON.parse(hostedpages_response.body)
        end

        return hostedpages_data
      else
        return nil
      end
  end


    # Create subscription using free plan
  def create_zoho_free_subscription

    # Fetch access token - If time.now is larger than last update in data entry then create new token else fetch from DB
    access_token = check_token_expiry_fetch_tocken

    if access_token
          # subscription data
        subscription_data = {customer: {display_name: @params[:display_name], first_name: @params[:first_name], last_name: @params[:last_name], email: @params[:email], company_name: @params[:company_name], currency_code: 'USD'}, plan: {name: "Free Plan", plan_code: "Free", plan_description: "Free Plan", price: 0, quantity: 1}, auto_collect: false}
        # subscription_data = {pricebook_id: '3630804000000089048', customer: {display_name: @params[:display_name], first_name: @params[:first_name], last_name: @params[:last_name], email: @params[:email], company_name: @params[:company_name], currency_code: 'USD'}, plan: {name: "Free Plan", plan_code: "Free", plan_description: "Free Plan", price: 0, quantity: 1}, auto_collect: false}

        begin
           # Create the HTTP request
          uri = URI("https://subscriptions.zoho.com/api/v1/subscriptions?organization_id=#{Rails.application.secrets.zoho_organization_id}")
          # uri = URI("https://subscriptions.zoho.com/api/v1/subscriptions?organization_id=794958424")
          req = Net::HTTP::Post.new(uri)
          req["Content-Type"] = "application/json"
          req["Authorization"] = "Zoho-oauthtoken #{access_token}"
          req.body = subscription_data.to_json

          # Send the request and get the response
          res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(req)
          end

        rescue StandardError => e
        end

        # Parse the response
        response_data = JSON.parse(res.body)

        # Check if the subscription was created successfully
        if res.is_a?(Net::HTTPSuccess)
          subscription_id = response_data["subscription"]["subscription_id"]
          puts "Successfully created subscription with ID: #{subscription_id}"
          result_data = {status: true, message: "Success", data: response_data}
        else  
          puts "Failed to create subscription: #{response_data["message"]}"
          result_data = {status: false, message: response_data["message"], data: nil}
        end

    else
      return {status: false, message: "Error on get Access token", data: nil}
    end

  end



  def update_zoho_subscription

  # Fetch access token - If time.now is larger than last update in data entry then create new token else fetch from DB
    access_token = check_token_expiry_fetch_tocken

    if access_token
          # subscription data
        # subscription_data = {subscription_id: @params[:zoho_subscription_id], plan: {plan_code: @params[:plan_code], plan_description: @params[:plan_description], price: @params[:price], quantity: 1}, redirect_url: "http://localhost:3000/user/zoho_call_back" }
        subscription_data = {pricebook_id: Rails.application.secrets.zoho_pricebook_id, subscription_id: @params[:zoho_subscription_id], plan: {plan_code: @params[:plan_code], plan_description: @params[:plan_description], price: @params[:price], quantity: 1}, redirect_url: Rails.application.secrets.zoho_call_back_url } 
                 
        begin
           # Create the HTTP request
          uri = URI("https://subscriptions.zoho.com/api/v1/hostedpages/updatesubscription?organization_id=#{Rails.application.secrets.zoho_organization_id}")
          req = Net::HTTP::Post.new(uri)
          req["Content-Type"] = "application/json"
          req["Authorization"] = "Zoho-oauthtoken #{access_token}"
          req.body = subscription_data.to_json

          # Send the request and get the response
          res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(req)
          end

        rescue StandardError => e
        end

        # Parse the response
        response_data = JSON.parse(res.body)
        # binding.pry 

        # Check if the subscription was created successfully
        if res.is_a?(Net::HTTPSuccess)
          puts "Successfully updated subscription with ID:"
          return {status: true, message: "Success", data: response_data}
        else  
          puts "Failed to updated subscription: #{response_data["message"]}"
          return {status: false, message: response_data["message"], data: nil}
        end

    else
      return {status: false, message: "Error on get Access token", data: nil}
    end
  end


  def get_hostedpages_details

    zoho_token_details = ZohoToken.first
    time_diff = (Time.current - zoho_token_details.updated_at).to_i

    # binding.pry 
    # Rails.application.secrets.zoho_client_id

    # Check the aceess token is expired or not. Normaly access token has 1 hrs of expiry.
    # Once its expired, fetch the access token using refresh token and save the same to our DB
    if time_diff > zoho_token_details.token_expires_in.to_i  

        # Fetch Access token
        begin
          new_token_response = RestClient.post("https://accounts.zoho.com/oauth/v2/token", {:refresh_token => @refresh_token , :client_id => Rails.application.secrets.zoho_client_id, :client_secret => Rails.application.secrets.zoho_client_secret, :redirect_uri => Rails.application.secrets.zoho_redirect_uri, :grant_type => "refresh_token"})
        rescue StandardError => e
        end

        # Parse Json data
        if new_token_response
          new_token = JSON.parse(new_token_response.body)
        end

        # Save Access token to DB
        zoho_token_details.access_token = new_token['access_token']
        zoho_token_details.token_expires_in = new_token['expires_in']
        if zoho_token_details.valid?
          zoho_token_details.save
        end

        # Fetch Hosted page payload
        return fetch_hostedpages_payload(new_token['access_token'])
    else
        # Fetch Hosted page payload
        # access_token = zoho_token_details.access_token
      return fetch_hostedpages_payload(zoho_token_details.access_token)
    end
  end



end