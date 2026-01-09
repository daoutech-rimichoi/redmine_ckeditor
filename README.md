# Redmine CKEditor 플러그인 (Daoutech 커스텀 버전)

## 버전 정보

- **플러그인 버전**: 1.2.7, Daoutech 0.0.1
- **CKEditor 버전**: 4.22.1
- **기반 버전**: [redmine_ckeditor 1.2.3](https://github.com/a-ono/redmine_ckeditor)
- **지원 Redmine 버전**: 4.0.0 이상 (Redmine 6.X 테스트 완료)

## 주요 수정 내용

### 1. 설정 페이지 오류 수정
- `ckeditor_javascripts` 변수 누락으로 인한 500 오류 해결
- 참조: [issue #308](https://github.com/a-ono/redmine_ckeditor/issues/308)

### 2. CKEditor 업그레이드
- 버전 4.22.1로 업그레이드
- Android Chrome 브라우저 복사/붙여넣기 지원
- 유료 플러그인(`exportpdf`) 비활성화

### 3. Redmine 5.X/6.X 호환성
- Zeitwerk 로더 지원
- Rails 6.X 호환성 개선
- Deprecated 메서드 대체

## 설치 방법

```bash
# 1. 플러그인 디렉토리로 이동
cd {REDMINE_ROOT}/plugins

# 2. 플러그인 복사 또는 클론
# 플러그인 디렉토리명은 반드시 'redmine_ckeditor'여야 합니다

# 3. Redmine 루트로 이동
cd {REDMINE_ROOT}

# 4. 의존성 설치
bundle install --without development test

# 5. 플러그인 마이그레이션 실행
bundle exec rake redmine:plugins:migrate NAME=redmine_ckeditor RAILS_ENV=production

# 6. 웹서버 재시작
# Apache/Passenger의 경우
touch tmp/restart.txt

# Puma/Unicorn의 경우
sudo systemctl restart redmine
```

## 삭제 방법

```bash
# 1. Redmine 루트로 이동
cd {REDMINE_ROOT}

# 2. 플러그인 마이그레이션 롤백
bundle exec rake redmine:plugins:migrate NAME=redmine_ckeditor VERSION=0 RAILS_ENV=production

# 3. 플러그인 디렉토리 삭제
rm -rf plugins/redmine_ckeditor

# 4. 웹서버 재시작
# Apache/Passenger의 경우
touch tmp/restart.txt

# Puma/Unicorn의 경우
sudo systemctl restart redmine
```

## 라이선스

원본 프로젝트의 라이선스를 따릅니다.
