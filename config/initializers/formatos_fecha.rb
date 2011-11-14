#http://jasonseifer.com/2010/03/10/rails-date-formats
# en rails2 era ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS http://brian.rarevisions.net/extending-date-formats-in-rails-3

Date::DATE_FORMATS[:default] = '%d/%m/%Y'
Time::DATE_FORMATS[:default]= '%d/%m/%Y %H:%M'

Date::DATE_FORMATS[:amd] = '%Y-%m-%d'
Time::DATE_FORMATS[:dma] = "%d/%m/%Y"

class String
  def to_date
    Date.strptime(self, '%d/%m/%Y')
  end
end

class Date #http://chris.finne.us/2011/10/15/parse-american-dates-with-ruby-19-in-rails/
  def self._parse(str, comp=false)
    date_array = str.split('/')
    {:mon => date_array[1].to_i, :year => date_array[2].to_i, :mday => date_array[0].to_i}
  end
end
