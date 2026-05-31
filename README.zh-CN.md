# MBB Page Maker

这是一个用来生成咨询公司风格 HTML PPT 的 skill package：战略汇报、董事会材料、投资 memo、管理层决策页等。
目标是让 AI coding agent 能通过一个可安装的静态包，稳定地生成、预览，并导出高质量管理层汇报材料。

设计约束：

```txt
- 一条命令安装。
- 不需要 build。
- 纯静态 HTML/CSS/JS。
- 默认导出自包含 HTML package、PDF 和 PNG。
```

## 示例 Gallery

<p align="center">
  <a href="examples/ai-erp-saas-lop/index.html"><img src="assets/media/readme/ai-erp-saas-lop.gif" alt="AI Product Operating Plan for an ERP SaaS Incumbent" width="360"></a>
  <a href="examples/agent-technology-outlook/index.html"><img src="assets/media/readme/agent-technology-outlook.gif" alt="Agent Technology Outlook" width="360"></a>
</p>
<p align="center">
  <a href="examples/enterprise-intelligence-transformation/index.html"><img src="assets/media/readme/enterprise-intelligence-transformation.gif" alt="AI-Era Enterprise Intelligence Transformation" width="360"></a>
  <a href="examples/ai-application-investment-thesis/index.html"><img src="assets/media/readme/ai-application-investment-thesis.gif" alt="AI Application Software Investment Thesis" width="360"></a>
</p>

## 安装

```bash
npx skills add https://github.com/NomiciAI/mbb-page-maker
```

GitHub 仓库：[NomiciAI/mbb-page-maker](https://github.com/NomiciAI/mbb-page-maker)

这条命令会直接从公开 GitHub 仓库安装 skill package。

为了让更多 agent 自动发现，推荐安装到所有检测到的客户端：

```bash
npx skills add https://github.com/NomiciAI/mbb-page-maker --agent '*'
```

如果 Claude Code、Cursor、Codex、OpenClaw、Hermes 或其他客户端显示 `Unknown skill`，但 `.agents/skills/mbb-page-maker/` 已存在，说明包已经安装，只是没有链接到该客户端自己的 skill 目录。运行：

```bash
.agents/skills/mbb-page-maker/scripts/link-agent-adapters.sh .
```

具体项目级/全局路径和 Claude Code 排查见 `references/agent-compatibility.md`。

## Quick Start

```bash
# 本地打开一个公开 demo deck
open examples/ai-erp-saas-lop/index.html

# 从 starter template 新建一个 deck
./scripts/new-deck.sh my-talk
open my-talk/index.html

# 导出自包含 HTML package、PDF 和 PNG 页面图
./scripts/render.sh my-talk/index.html
open my-talk/dist/package/index.html
```

## Design System

MBB Page Maker 是纯静态 HTML/CSS/JS。源 deck 保持可读、可编辑，同时 `scripts/render.sh` 可以把它打包成一个可分享的自包含 HTML 文件。

CSS 按职责拆分：

- `base.css`: slide 画布、字体层级、runtime controls 和 print 规则。
- `layouts.css`: 页面级 layout shell。
- `components.css`: 表格、卡片、指标、roadmap、矩阵和 profile blocks。
- `illustrations.css`: 中性视觉 primitives 和静态资源插槽。
- `themes/*.css`: blue、green、red、pitch、mono、classic 等主题 token。
- `assets/media/`: 可选静态图片、cover、截图和 showcase 素材。

生成的 deck 使用同一套静态文件顺序：`fonts.css`, `base.css`, `layouts.css`, `components.css`, `illustrations.css`, 一个 theme 文件，再加 `runtime.js`。源码不需要 build。

新 deck 可以从 `templates/starter-deck.html` 开始。`templates/deck.html` 是 design-system gallery 和组件 tour。`templates/full-decks/` 放完整 storyline archetype，`templates/showcase/` 放 page-level pattern 和 theme/layout/component 组合。公开 demo 在 `examples/`，独立于 templates 维护。

运行 `scripts/render.sh path/to/deck.html` 可导出自包含 HTML package、PDF 和 PNG 页面图。最终 package 会内联本地 CSS、JavaScript、字体和媒体资源，让 `package/index.html` 可以直接用浏览器打开。更细的生成规则放在 `SKILL.md` 和 `references/`。

## 项目结构

核心结构分成五层：

- `SKILL.md`: skill 入口和调度规则。
- `references/`: agent 兼容性、pattern index、主题、布局、视觉资产、咨询式思考流程、完整 deck 结构和写作流程。
- `assets/`: 静态 HTML PPT runtime、CSS design system、主题 token。
- `templates/`: `starter-deck.html`、design-system gallery、full-deck archetype、showcase 思维/组合案例、light/dark/mixed/neutral skeleton 和布局模板。
- `scripts/`: 新建 deck、字体刷新、agent adapter 链接、可见性检查和导出 PNG/PDF/HTML。

## 贡献

欢迎通过 pull request 贡献。`main` 分支受保护：Saitop 可以直接 push，其他 collaborator 和外部 contributor 都应通过 PR 提交变更。

PR 规则、测试说明和仓库维护要求见 `CONTRIBUTING.md`。

## 致谢

受 [lewislulu/html-ppt-skill](https://github.com/lewislulu/html-ppt-skill) 启发。本项目为从零编写，拥有独立的结构、模板、运行时和设计系统。

## License & Author

Apache-2.0. Copyright 2026 Saitop <<saitop@nomici.ai>>.
