class Users::LocationsController < Users::ProfilesController
  def edit
    return unless current_user.locations.blank?
    current_user.locations.build
  end

  def update
    return if current_user.update(location_params)
    render :edit
  end

  def address_check
    url = URI.encode("https://apis.daum.net/local/geo/addr2coord?apikey=#{ENV['daum_api_key']}&q=#{params[:q]}&page_size=7&output=json")
    response = RestClient.get url
    results = JSON.parse(response)['channel']['item']
    render json: { results: results }
  end

  protected

  def location_params
    params
      .fetch(:user, {})
      .permit(locations_attributes: [:id,
                                     :user_id,
                                     :full_address,
                                     :lng,
                                     :lat,
                                     :mountain,
                                     :localName_1,
                                     :localName_2,
                                     :localName_3,
                                     :main_address,
                                     :sub_address,
                                     :building_address,
                                     :is_new_address,
                                     :new_address,
                                     :zipcode,
                                     :zone_no,
                                     :distance,
                                     :is_checked,
                                     :_destroy])
  end
end
