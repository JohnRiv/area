class Integer


  # Public: Convert an area code or to a US state or region.
  #
  # Examples
  #
  #   646.to_region
  #   #=> NY
  #
  # Returns a String representation of the converted area code.
  def to_region(options = {})
    if Area.code?(self) # presume an area code
      row = Area.area_codes.find{|row| row.first == self.to_s }
      row.last if row
    end
  end


  # Public: Convert an area code or zipcode to its latitude and longitude.
  #
  # Examples
  #
  #   11211.to_latlon
  #   #=> "40.71209, -73.95427"
  #
  # Returns a String representation of the lat/lon pair.
  def to_latlon
    if Area.zip?(self)
      warn "[DEPRECATION] using `to_latlon` with an integer representation of a zipcode is deprecated and will be removed in future versions. Please use a string instead."
      row = Area.zip_codes.find {|row| row.first == self.to_s }
      row[3] + ', ' + row[4] if row
    end
  end


  # Public: Convert a zipcode to its latitude.
  #
  # Examples
  #
  #   11211.to_lat
  #   #=> "40.71209"
  #
  # Returns a String representation of the latitude.
  def to_lat
    if Area.zip?(self)
      warn "[DEPRECATION] using `to_lat` with an integer representation of a zipcode is deprecated and will be removed in future versions. Please use a string instead."
      row = Area.zip_codes.find {|row| row.first == self.to_s }
      row[3] if row
    end
  end


  # Public: Convert a zipcode to its longitude.
  #
  # Examples
  #
  #   11211.to_lon
  #   #=> "40.71209"
  #
  # Returns a String representation of the longitude.
  def to_lon
    if Area.zip?(self)
      warn "[DEPRECATION] using `to_lon` with an integer representaion of a zipcode is deprecated and will be removed in future versions. Please use a string instead."
      row = Area.zip_codes.find {|row| row.first == self.to_s }
      row[4] if row
    end
  end


  # Public: Convert a zipcode to its GMT offset.
  #
  # Examples
  #
  #   11211.to_gmt_offset
  #   #=> "-5"
  #
  # Returns a String representation of the GMT offset.
  def to_gmt_offset(options = {})
    if Area.zip?(self)
      warn "[DEPRECATION] using `to_gmt` with an integer representaion of a zipcode is deprecated and will be removed in future versions. Please use a string instead."
      options[:use_dst] = true if options[:use_dst].nil?
      row = Area.zip_codes.find {|row| row.first == self.to_s }
      apply_dst(row[5], row[6], options[:use_dst]) if row
    end
  end


  # Public: Determine if a zipcode observes daylight savings time.
  #
  # Examples
  #
  #   11211.to_dst
  #   #=> "1"
  #
  # Returns a String representation of of the daylight savings time observance.
  def to_dst
    if Area.zip?(self)
      warn "[DEPRECATION] using `to_dst` with an integer representaion of a zipcode is deprecated and will be removed in future versions. Please use a string instead."
      row = Area.zip_codes.find {|row| row.first == self.to_s }
      row[6] if row
    end
  end

  # Public: Return boolean for daylight savings time observance.
  #
  # Examples
  #
  #   11211.observes_dst?
  #   #=> true
  #
  # Returns a Boolean of the daylight savings time observance.
  def observes_dst?
    to_dst == "1"
  end

  private
  def apply_dst(offset, dst, use_dst)
    # Daylight savings starts from Eastern time in US
    if use_dst && TZInfo::Timezone.get('US/Eastern').current_period.dst?
      (offset.to_i + dst.to_i).to_s
    else
      offset
    end
  end
end
