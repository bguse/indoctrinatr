# == Schema Information
#
# Table name: templates
#
#  id                  :integer          not null, primary key
#  name                :string(255)      default(""), not null
#  content             :text             default(""), not null
#  created_at          :datetime
#  updated_at          :datetime
#  template_asset_path :string(255)
#  template_pack_id    :integer
#

class Template < ActiveRecord::Base
  # associations
  has_many :template_fields, dependent: :destroy
  has_many :document_submissions, dependent: :destroy
  has_one :template_pack

  accepts_nested_attributes_for :template_fields, allow_destroy: true

  # validations
  validates :name, presence: true
  validates :content, presence: true

  def template_type
    is_template_package? ? 'Template Pack' : 'Template'
  end

  def is_template_package?
    template_pack.present?
  end
end
