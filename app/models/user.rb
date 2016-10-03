class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true

  def inflate_from_legacy_survey_response(legacy_survey_response)
    parts = legacy_survey_response.name.split

    self.first_name = parts[0..(parts.length - 2)]
    self.last_name = parts[-1] if parts.count > 1

    self.email = legacy_survey_response.email
    self.zip_code = legacy_survey_response.zip_code

    self.legacy_survey_response_id = legacy_survey_response.id
  end
end
