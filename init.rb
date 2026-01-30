# frozen_string_literal: true

# Redmine CKEditor Plugin
# Redmine 6 (Rails 7) 지원

# Zeitwerk 오토로더 설정
# lib 디렉토리는 명시적 require가 필요한 레거시 코드이므로 오토로딩에서 제외
base_path = File.dirname(__FILE__)
if Rails.configuration.respond_to?(:autoloader) && Rails.configuration.autoloader == :zeitwerk
  Rails.autoloaders.each { |loader| loader.ignore("#{base_path}/lib") }
end

# 레거시 lib 파일 명시적 로드
require "#{base_path}/lib/redmine_ckeditor"

# 플러그인 등록
Redmine::Plugin.register :redmine_ckeditor do
  name 'Redmine CKEditor plugin'
  author 'rimichoi'
  description 'This is a CKEditor plugin for Redmine'
  version '1.2.7, Daoutech 0.0.2'
  requires_redmine :version_or_higher => '5.0.0'
  url 'https://github.com/daoutech-rimichoi/redmine_ckeditor'
  author_url 'mailto:rimichoi@daou.co.kr'

  settings partial: 'settings/ckeditor'

  wiki_format_provider 'CKEditor', RedmineCkeditor::WikiFormatting::Formatter,
    RedmineCkeditor::WikiFormatting::Helper
end

# Rails 초기화 및 리로드(개발 모드) 시 실행
Rails.configuration.to_prepare do
  # CKEditor 패치 적용
  RedmineCkeditor.apply_patch
  
  # Loofah 보안 설정 (HTML sanitization)
  safe_list_class = Loofah::VERSION >= "2.3.0" ? Loofah::HTML5::SafeList : Loofah::HTML5::WhiteList
  safe_list_class::ALLOWED_PROTOCOLS.replace RedmineCkeditor.allowed_protocols
  
  # data: protocol 추가 (이미지 임베딩 등을 위해)
  if defined?(Loofah::HTML5::WhiteList)
    Loofah::HTML5::WhiteList::ALLOWED_PROTOCOLS.add('data')
  end
end

# Redmine 6.XX에서 assets을 public/plugin_assets 폴더로 복사
# (Redmine 5.XX 호환성 유지를 위해)
RedmineCkeditor.copy_assets_to_public_in_R6XX
