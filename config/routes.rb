RedmineApp::Application.routes.draw do
  mount Rich::Engine => '/rich', :as => 'rich'

  scope :redmine_ckeditor do
    # URI는 동일하게 'image'로 통일
    post 'image', to: 'redmine_ckeditor#upload_image'
    get  'image', to: 'redmine_ckeditor#view_image'
    
    get  'rich_files',   to: 'redmine_ckeditor#rich_files'
    get  'users',        to: 'redmine_ckeditor#users',  as: 'ckeditor_users',  format: :json
    get  'issues',       to: 'redmine_ckeditor#issues', as: 'ckeditor_issues', format: :json
  end
end
