class SampleFolder < ApplicationRecord
 include Geturlable
	 has_many :sample_uploads
	 
end
