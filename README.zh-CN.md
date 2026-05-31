# MBB Page Maker

这是一个 world-class AgentSkill，用来生成咨询公司风格的 HTML PPT：战略汇报、董事会材料、投资 memo、管理层决策页等。
目标是让任何有 skill 能力的 agent，都能通过一个可安装的静态包，稳定地生成、预览，并逐步导出高质量管理层汇报材料。

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

这条命令会直接从公开 GitHub 仓库安装 AgentSkill。

为了让更多 agent 自动发现，推荐安装到所有检测到的客户端：

```bash
npx skills add https://github.com/NomiciAI/mbb-page-maker --agent '*'
```

如果 Claude Code、Cursor、Codex、OpenClaw、Hermes 或其他客户端显示 `Unknown skill`，但 `.agents/skills/mbb-page-maker/` 已存在，说明包已经安装，只是没有链接到该客户端自己的 skill 目录。运行：

```bash
.agents/skills/mbb-page-maker/scripts/link-agent-adapters.sh .
```

具体项目级/全局路径和 Claude Code 排查见 `references/agent-compatibility.md`。

## 当前结构

核心结构分成五层：

- `SKILL.md`: AgentSkill 入口和调度规则。
- `references/`: agent 兼容性、pattern index、主题、布局、视觉资产、咨询式思考流程、完整 deck 结构和写作流程。
- `assets/`: 静态 HTML PPT runtime、CSS design system、主题 token。
- `templates/`: `starter-deck.html`、design-system gallery、full-deck archetype、showcase 思维/组合案例、light/dark/mixed/neutral skeleton 和布局模板。
- `scripts/`: 新建 deck、字体刷新、agent adapter 链接、可见性检查和导出 PNG/PDF/HTML。

后续拿到真正的参考样张后，再把主题、字体比例、标题系统、图表样式和页面组件精修到更贴近目标格式。

## Design System

CSS 按职责拆分：

- `base.css`: 画布、基础字体层级、runtime controls、print 规则。
- `layouts.css`: 页面级 layout shell。
- `components.css`: 表格、卡片、指标、agenda、矩阵、roadmap、profile blocks。
- `illustrations.css`: 中性插图 primitives 和静态资源插槽。
- `themes/*.css`: 只放颜色 token，每个主题同时支持 light/dark mode。
- `assets/media/`: 可选静态图片、SVG、截图和头像素材。
- `references/visual-assets.md`: cover art、支撑性视觉 primitive、bitmap 使用和网络素材 inspiration gate。

页面生成按组合方式进行：

1. 新 deck 从 `templates/starter-deck.html` 开始。
2. 选择 skeleton: neutral、light、dark 或 mixed。
3. 从 `templates/layouts/` 选择页面 layout。
4. 从 `templates/components/` 选择组件填入 layout。
5. 从 `assets/themes/` 选择一个主题 token。
6. 交付前运行 `scripts/check-deck-quality.sh path/to/deck.html`，检查是否有空 section 页或缺少组件的数据页。
7. 交付前运行 `scripts/check-deck-contrast.sh path/to/deck.html`，检查深色背景、pitch 风格和图片叠字页面是否有文字不可见。
8. 用户没有指定 HTML-only 时，运行 `scripts/render.sh path/to/deck.html` 默认导出自包含 HTML package、PDF 和 PNG 页面图。

`templates/full-decks/` 放完整 deck archetype，给 agent 参考 storyline pacing、页面角色和组件组合，不是 `examples` 的生成源，也不是固定套版。每个 full-deck 目录用 README sidecar 给 agent 快速索引。`templates/showcase/` 放 page-level thinking pattern 和 theme + layout + component 的组合案例，用于单页或局部 deck 组合参考。`references/pattern-index.md` 负责告诉 agent 什么时候读 full-deck、showcase、layout 或 component，并提醒 agent 根据用户材料自由重组。`examples/` 是独立公开 demo，其中 `examples/ai-erp-saas-lop/` 是一个 synthetic 26 页 AI 产品 LOP public flagship demo，使用 blue executive theme 和较完整的组件组合。

源 HTML 的 CSS/JS 保持静态分层：`fonts.css`, `base.css`, `layouts.css`, `components.css`, `illustrations.css`, 一个 theme 文件，再加 `runtime.js`。不做源码 build。`assets/css/fonts.css` 指向 `assets/fonts/google/` 里的预下载字体。最终 `scripts/render.sh --package` 会把本地 CSS、JS、字体和媒体资源内联进 `package/index.html`，让这个 HTML 文件可以被浏览器单独打开。

最终 package 会校验为自包含文件：不允许外部 stylesheet、外部 script、远程字体 URL、CSS `@import` 或未内联的媒体 URL。图表和视觉组件优先使用内置静态 HTML/CSS/SVG，不依赖 CDN runtime。

网络开放素材默认只作为 reference / seed / mood input，不直接把第三方原图打进仓库。进入 `assets/media/` 的通用视觉资产应为自生成或 repo-native，并保留 manifest/provenance 记录。

`starter-deck.html` 保持轻量：标题封面、简单 agenda/context、空白内容页、ending。普通内容页默认从空白内容页开始，再按用户数据组合 layout 和 component。各 skeleton 不需要页面完全一致，只需要遵守同一个 16:9 slide contract 和输出文件顺序。

## 贡献

欢迎通过 pull request 贡献。`main` 分支受保护：Saitop 可以直接 push，其他 collaborator 和外部 contributor 都应通过 PR 提交变更。

PR 规则、测试说明和仓库维护要求见 `CONTRIBUTING.md`。

## 致谢

受 [lewislulu/html-ppt-skill](https://github.com/lewislulu/html-ppt-skill) 启发。本项目为从零编写，拥有独立的结构、模板、运行时和设计系统。

## License & Author

Apache-2.0. Copyright 2026 Saitop.
