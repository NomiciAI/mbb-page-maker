# MBB Page Maker

这是一个 world-class AgentSkill，用来生成咨询公司风格的 HTML PPT：战略汇报、董事会材料、投资 memo、管理层决策页等。

目标是让任何有 skill 能力的 agent，都能通过一个可安装的静态包，稳定地生成、预览，并逐步导出高质量管理层汇报材料。

当前处于基础 HTML 骨架阶段。

设计约束：

- 一条命令安装。
- 不需要 build。
- 纯静态 HTML/CSS/JS。
- 只允许 CDN webfont。
- 先稳定可滑动 HTML 页面骨架；之后做 PNG/PDF；PowerPoint 最后研究。

## 安装

```bash
npx skills add https://github.com/NomiciAI/mbb-page-maker
```

GitHub 仓库：[NomiciAI/mbb-page-maker](https://github.com/NomiciAI/mbb-page-maker)

现在 repo 可以继续 private。等开源后，这条命令可以直接从 GitHub 安装。

## 当前结构

核心结构分成五层：

- `SKILL.md`: AgentSkill 入口和调度规则。
- `references/`: 主题、布局、完整 deck 结构和写作流程。
- `assets/`: 静态 HTML PPT runtime、CSS design system、主题 token。
- `templates/`: `starter-deck.html`、design-system gallery、light/dark/mixed/neutral skeleton 和布局模板。
- `scripts/`: 新建 deck 和导出 PNG/PDF/HTML。

后续拿到真正的参考样张后，再把主题、字体比例、标题系统、图表样式和页面组件精修到更贴近目标格式。

## Design System

CSS 按职责拆分：

- `base.css`: 画布、基础字体层级、runtime controls、print 规则。
- `layouts.css`: 页面级 layout shell。
- `components.css`: 表格、卡片、指标、agenda、矩阵、roadmap、profile blocks。
- `illustrations.css`: 中性插图 primitives 和静态资源插槽。
- `themes/*.css`: 只放颜色 token，每个主题同时支持 light/dark mode。
- `assets/media/`: 可选静态图片、SVG、截图和头像素材。

页面生成按组合方式进行：

1. 新 deck 从 `templates/starter-deck.html` 开始。
2. 选择 skeleton: neutral、light、dark 或 mixed。
3. 从 `templates/layouts/` 选择页面 layout。
4. 从 `templates/components/` 选择组件填入 layout。
5. 从 `assets/themes/` 选择一个主题 token。

CSS/JS 输出保持静态分层：`fonts.css`, `base.css`, `layouts.css`, `components.css`, `illustrations.css`, 一个 theme 文件，再加 `runtime.js`。不做 build，不做 CSS bundle。

## License & Author

MIT. Copyright (c) 2026 Saitop at NomiciAI <saitop@nomici.ai>.
