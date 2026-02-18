# iTerm2 Power User Setup

macOS iTerm2 파워 유저 환경을 한 번에 세팅하는 자동화 스크립트.

이미 설정이 되어 있어도 `--reset`으로 초기화 후 새로 세팅할 수 있다.

## 설치

```bash
git clone git@github.com:ixtears23/iterm_setting.git
cd iterm_setting
./install.sh
```

### 초기화 후 재설치

```bash
./install.sh --reset
```

## 설치 항목

### Homebrew + CLI 도구 (16종)

| 도구 | 설명 |
|------|------|
| `fzf` | 퍼지 파인더 |
| `ripgrep` | 빠른 텍스트 검색 |
| `bat` | cat 대체 (구문 강조) |
| `eza` | ls 대체 (아이콘, git 상태) |
| `fd` | find 대체 |
| `git-delta` | git diff 뷰어 |
| `zoxide` | cd 대체 (스마트 디렉토리 이동) |
| `lazygit` | 터미널 Git UI |
| `neovim` | 에디터 |
| `tmux` | 터미널 멀티플렉서 |
| `jq` / `yq` | JSON/YAML 처리 |
| `htop` | 프로세스 모니터 |
| `tree` | 디렉토리 트리 |
| `gh` | GitHub CLI |
| `tldr` | 명령어 요약 매뉴얼 |

### Zsh 환경

- **Oh My Zsh** + 플러그인 (autosuggestions, syntax-highlighting, completions)
- **Powerlevel10k** — Catppuccin Mocha 톤 Rainbow 스타일
- **MesloLGS Nerd Font**

### iTerm2

- Catppuccin Mocha 컬러 테마 자동 적용
- 프로필 설정 (폰트, 키맵핑 등)

### Dotfiles

설정 파일들을 심링크로 배포한다. 기존 파일은 자동 백업.

| 파일 | 용도 |
|------|------|
| `configs/.zshrc` | Zsh 설정 (앨리어스, FZF, 도구 초기화) |
| `configs/.p10k.zsh` | Powerlevel10k 프롬프트 설정 |
| `configs/.gitconfig.delta` | git-delta side-by-side diff 설정 |

## 프로젝트 구조

```
iterm_setting/
├── install.sh              # 메인 진입점
├── scripts/
│   ├── utils.sh            # 공통 유틸
│   ├── brew.sh             # Homebrew
│   ├── fonts.sh            # Nerd Font
│   ├── zsh.sh              # Oh My Zsh + P10k + 플러그인
│   ├── tools.sh            # CLI 도구
│   ├── iterm2.sh           # iTerm2 설정
│   └── dotfiles.sh         # dotfiles 배포
├── configs/
│   ├── .zshrc              # Zsh 설정
│   ├── .p10k.zsh           # P10k 설정
│   └── .gitconfig.delta    # git-delta 설정
└── themes/                 # iTerm2 컬러 테마 (런타임 다운로드)
```

## 요구 사항

- macOS (Apple Silicon / Intel)
- iTerm2 설치 또는 스크립트가 자동 설치
