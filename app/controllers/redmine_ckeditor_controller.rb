require "fileutils"

# This file is a part of Redmine CKEditor plugin
# for Redmine
#
# Copyright 2020-2024 RedmineX. All Rights Reserved.
# https://www.redmine-x.com
#
# Licensed under GPL v2 (http://www.gnu.org/licenses/gpl-2.0.html)
# Created by Ondřej Svejkovský

class RedmineCkeditorController < ApplicationController
  include AvatarsHelper

  # Path configuration
  UPLOAD_IMAGE_PATH = File.join(Redmine::Configuration['attachments_storage_path'] || File.join(Rails.root, 'files'), 'upload_images')

  # Skip login check for file upload/display if necessary.
  # WARNING: Removing this line requires users to be logged in to see/upload images.
  # skip_before_action :check_if_login_required

  # Only skip CSRF check for the upload action (CKEditor sends standard form posts)
  skip_before_action :verify_authenticity_token, only: [:upload_image]

  before_action :find_project

  def upload_image
    uploaded_io = params[:upload]
    
    # Generate safe filename: YYMMDDHHMMSS + 3 random chars + sanitized original name
    random_str = SecureRandom.alphanumeric(3)
    original_name = File.basename(uploaded_io.original_filename)
    file_name = "#{DateTime.now.strftime('%y%m%d%H%M%S')}#{random_str}_#{original_name}"

    # Determine save path
    target_path = File.join(mkdir_upload_path, file_name)

    # Save file securely (binary mode)
    File.open(target_path, 'wb') do |file|
      file.write(uploaded_io.read)
    end

    url = "/redmine_ckeditor/image?file_name=#{file_name}"

    respond_to do |format|
      format.json do
        render json: { uploaded: "1", fileName: file_name, url: url }
      end
    end
  end

  def mkdir_upload_path
    today = Time.zone.now
    path = File.join(UPLOAD_IMAGE_PATH, today.strftime("%y"), today.strftime("%m"))
    
    FileUtils.mkdir_p(path) unless Dir.exist?(path)
    path
  end

  def view_image
    # Security: Prevent Directory Traversal
    safe_filename = File.basename(params[:file_name])
    
    # Validation: Ensure filename starts with YYMM (numeric)
    unless safe_filename.match?(/^\d{4}/)
      render plain: "Invalid filename", status: :bad_request
      return
    end

    year = safe_filename[0..1]
    month = safe_filename[2..3]
    
    file_path = File.join(UPLOAD_IMAGE_PATH, year, month, safe_filename)

    if File.exist?(file_path)
      send_file file_path, filename: safe_filename, disposition: 'inline'
    else
      render plain: "File not found", status: :not_found
    end
  end

  def rich_files
    respond_to do |format|
      format.html { render layout: false, partial: "rich/files/file" }
    end
  end

  # Delivers data of user mention suggestions
  def users
    users_query = helpers.user_suggestions_query(params[:name], @project)
    suggestions_data = helpers.prepare_user_suggestions(users_query)

    render json: suggestions_data
  end

  def issues
    issues_query = helpers.issue_suggestions_query(params[:name], @project)
    suggestions_data = helpers.prepare_issue_suggestions(issues_query)

    render json: suggestions_data
  end

  private

  def find_project
    @project = Project.find_by(id: params[:project_id])
  end
end