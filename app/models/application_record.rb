# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def purge_attachment(attachment_id)
    @attachment = ActiveStorage::Attachment.find(attachment_id)
    @attachment&.purge
  end
end
