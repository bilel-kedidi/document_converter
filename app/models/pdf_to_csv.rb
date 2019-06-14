require 'httmultiparty'
class PdfToCsv
  include HTTMultiParty
  base_uri 'http://localhost:3000'

  attr_accessor :pdf_path
  def initialize(name)
    @pdf_path = name
  end

  def convert
    response = PdfToCsv.post('https://pdftables.com/api?key=z53lo002k30s&format=csv', :query => { f: File.new(@pdf_path, "r") })
    response.body
  end

  def headers
    # CSV.foreach(File.join(Rails.root, 'public', 'response.csv'), headers: true) do |csv|
    #   csv.headers
    # end

    file  = File.join(Rails.root, 'public', 'response.csv')
    CSV::Converters[:blank_to_nil] = lambda do |field|
      field && field.empty? ? nil : field
    end
    csv = CSV.new(file, :headers => true, :header_converters => :symbol, :converters => [:all, :blank_to_nil])
    csv_data = csv.to_a.map {|row| row.to_hash }
  end

end