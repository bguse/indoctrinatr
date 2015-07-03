# == Schema Information
#
# Table name: submitted_template_fields
#
#  id                       :integer          not null, primary key
#  document_submission_id   :integer          not null
#  template_field_id        :integer          not null
#  value                    :text             not null
#  created_at               :datetime
#  updated_at               :datetime
#  file_upload_file_name    :string
#  file_upload_content_type :string
#  file_upload_file_size    :integer
#  file_upload_updated_at   :datetime
#

class SubmittedTemplateField < ActiveRecord::Base
  # paperclip attachment
  has_attached_file :file_upload
  do_not_validate_attachment_file_type :file_upload

  # associations
  belongs_to :document_submission
  belongs_to :template_field

  # delegations
  delegate :name, to: :template_field
  delegate :to_form_label, to: :template_field

  # Callbacks
  after_initialize :set_value_to_empty_string
  validate :template_field_required?

  def set_value_to_empty_string
    return nil if template_field.required? && value.blank?
    return value if value.present?
    self.value = ''
  end

  def template_field_required?
    if template_field.required?
      if template_field.file?
        errors.add :file_upload, 'Datei muss vorhanden sein!' if file_upload.blank?
      else
        errors.add :file_upload, 'Wert muss vorhanden sein!' if value.blank?
      end
    end
  end

  def value_or_default
    return file_upload_path_or_empty_string if template_field.file?

    value_or_default_value
  end

  private

  def file_upload_path_or_empty_string
    self.value = ''
    if file_upload.present?
      file_upload.path
    else
      ''
    end
  end

  def value_or_default_value
    if value.present?
      value
    else
      template_field.default_value
    end
  end
end
