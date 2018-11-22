require "csv"
require 'google/apis/drive_v2'

class FileCollection
  
  Drive = Google::Apis::DriveV2

  def collect_in_folder(user, file_path)
    client = Drive::DriveService.new(access_token)
    CSV.open(file_path, csv_options) do |csv|
      File.all.each do |file|
        file, metadata = client.get_file_and_metadata(file_path)
        open(file, 'w')
        csv << [file.title, file.description]
      end
    end
    sleep(5)
    # for a mailer
    FileUploaderMailer.send_file(user, file_path).deliver_now
  end

  private

  def csv_options
    {
      write_headers: true,
      headers: %w[title description],
      col_sep: ";"
    }
  end
end
