class DataFile < ApplicationRecord
  require 'fileutils'
  before_destroy :delete_file

  belongs_to :repository, polymorphic: true

  def dir_path
    Rails.root.join('public', 'uploads', self.uuid)
  end

  def file_path
    Rails.root.join('public', 'uploads', self.uuid, self.name)
  end

  private
    def delete_file
      FileUtils.rm_rf(self.dir_path)
    end
end
