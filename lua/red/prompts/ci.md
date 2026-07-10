---
name: Own Custom Git Prompt
interaction: chat
description: Identify the changes made without explanation
opts:
    alias: ci
    auto_submit: true
    is_slash_cmd: true
---

## user

You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me. No explanation for the changes. Just identify the changes and  use feat, hotfix, fix and etc.. No mentioning of file names 

```diff
${commit-func.diff}
```

