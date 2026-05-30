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
- `assets/`: 静态 HTML PPT runtime、CSS token、主题。
- `templates/`: starter deck、light/dark skeleton 和布局模板。
- `scripts/`: 新建 deck 和导出 PNG/PDF/HTML。

后续拿到真正的参考样张后，再把主题、字体比例、标题系统、图表样式和页面组件精修到更贴近目标格式。
