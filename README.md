# Redmine CKEditor Plugin (Daoutech 커스텀 버전)

Redmine에 CKEditor 4 WYSIWYG 에디터를 통합하는 플러그인입니다. Daoutech 환경에 맞게 커스터마이징되어 Redmine 6.X 버전을 완벽하게 지원합니다.

---

## 📋 주요 기능

### 1. CKEditor 4.22.1 통합
- **WYSIWYG 에디터**: 텍스트 편집 시 실시간으로 결과를 확인할 수 있습니다.
- **리치 텍스트 편집**: 글꼴, 색상, 표, 이미지 등 다양한 포맷팅 기능을 제공합니다.
- **코드 하이라이팅**: 코드 블록을 삽입하고 문법 강조 표시를 지원합니다.
- **이미지 업로드**: 드래그 앤 드롭으로 이미지를 쉽게 업로드할 수 있습니다.

### 2. Redmine 통합
- **일감 편집**: 일감 생성/수정 시 CKEditor 사용
- **Wiki 편집**: Wiki 페이지 편집 시 CKEditor 사용
- **포럼 편집**: 포럼 게시글 작성 시 CKEditor 사용
- **이슈 노트**: 일감 댓글 작성 시 CKEditor 사용

### 3. 모바일 지원
- **Android Chrome 호환**: Android Chrome 브라우저에서 복사/붙여넣기 정상 동작
- **반응형 디자인**: 모바일 환경에서도 편리한 편집 경험 제공

---

## 🛠 환경 구성

본 플러그인은 아래 환경에서 개발 및 테스트되었습니다.

- **Redmine**: 4.0.0 이상 (Redmine 6.X 테스트 완료)
- **Ruby**: 2.5 이상
- **Rails**: 5.2 이상 (Rails 7 지원)
- **CKEditor**: 4.22.1

---

## 🔧 Daoutech 커스텀 수정 내용

### 1. 설정 페이지 오류 수정
- `ckeditor_javascripts` 변수 누락으로 인한 500 오류 해결
- 참조: [issue #308](https://github.com/a-ono/redmine_ckeditor/issues/308)

### 2. CKEditor 업그레이드
- 버전 4.22.1로 업그레이드
- Android Chrome 브라우저 복사/붙여넣기 지원
- 유료 플러그인(`exportpdf`) 비활성화

### 3. Redmine 5.X/6.X 호환성
- Zeitwerk 로더 지원
- Rails 6.X/7.X 호환성 개선
- Deprecated 메서드 대체

---

## 📦 설치 방법

### 1. 플러그인 다운로드
레드마인의 `plugins` 디렉토리로 이동하여 저장소를 복제합니다.  
⚠️ **폴더명은 반드시 `redmine_ckeditor`여야 합니다.**

```bash
cd {REDMINE_ROOT}/plugins
git clone [repository_url] redmine_ckeditor
```

### 2. 의존성 설치
레드마인 루트 디렉토리에서 번들러를 실행합니다.

```bash
cd {REDMINE_ROOT}
bundle install --without development test
```

### 3. 데이터베이스 마이그레이션 (필수)
플러그인 전용 테이블을 생성합니다.

```bash
bundle exec rake redmine:plugins:migrate NAME=redmine_ckeditor RAILS_ENV=production
```

### 4. 서버 재시작
변경 사항 적용을 위해 레드마인 서버를 재시작합니다.

```bash
# Apache/Passenger의 경우
touch tmp/restart.txt

# Puma/Unicorn의 경우
sudo systemctl restart redmine

# Docker의 경우
docker-compose restart redmine
```

---

## ⚙️ 설정 방법

### 1. 플러그인 설정 접속
- 레드마인 상단 메뉴에서 **관리(Administration)** 클릭
- 좌측 메뉴에서 **플러그인(Plugins)** 클릭
- **Redmine CKEditor plugin** 찾기
- **설정(Configure)** 버튼 클릭

### 2. 에디터 옵션 설정
- **에디터 활성화 영역**: CKEditor를 사용할 영역 선택
  - ☑ 일감 (Issues)
  - ☑ Wiki
  - ☑ 포럼 (Forums)
  - ☑ 뉴스 (News)
- **툴바 설정**: 표시할 툴바 버튼 선택
- **언어 설정**: 에디터 UI 언어 선택

### 3. 저장
- **적용(Apply)** 버튼 클릭

---

## 🗑 삭제 방법

### 1. 데이터베이스 롤백
플러그인 제거 전, 생성된 테이블을 삭제하기 위해 마이그레이션을 롤백합니다.

```bash
cd {REDMINE_ROOT}
bundle exec rake redmine:plugins:migrate NAME=redmine_ckeditor VERSION=0 RAILS_ENV=production
```

### 2. 디렉토리 삭제
플러그인 디렉토리를 제거합니다.

```bash
rm -rf plugins/redmine_ckeditor
```

### 3. 서버 재시작
서버를 재시작하여 플러그인을 완전히 제거합니다.

```bash
# Apache/Passenger의 경우
touch tmp/restart.txt

# Puma/Unicorn의 경우
sudo systemctl restart redmine

# Docker의 경우
docker-compose restart redmine
```

---

## 📌 버전 정보

- **플러그인 버전**: 1.2.7, Daoutech 0.0.1
- **CKEditor 버전**: 4.22.1
- **기반 버전**: [redmine_ckeditor 1.2.3](https://github.com/a-ono/redmine_ckeditor)
- **지원 Redmine 버전**: 4.0.0 이상 (Redmine 6.X 테스트 완료)

---

## 📝 라이선스

원본 프로젝트의 라이선스를 따릅니다.

