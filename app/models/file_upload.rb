class FileUpload < ApplicationRecord
  has_secure_token :token
  mount_uploader :file, DocumentUploader

  after_create :convert_to_csv

  def convert_to_csv
    pdf = PdfToCsv.new(self.file.path)
    csv = pdf.convert
    time_now = Time.now.to_i
    File.open(File.join(Rails.root, 'public', 'csv', "#{time_now}.csv"), 'w') do |f|
      f.puts csv
    end
    self.update_columns(csv_path: File.join(Rails.root, 'public', 'csv', "#{time_now}.csv"))
  end

end
