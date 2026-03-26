---
description: "Create a git commit with meaningful message based on file changes"
argument-hint: "[optional: -m 'override message']"
allowed-tools: Read, Glob, Grep, Bash
---

# Git Commit Command

Create a git commit with a meaningful, content-aware message. This command analyzes actual file changes to generate descriptive commit messages.

**Key difference from built-in commit**: This command does NOT add the Claude Co-Authored-By footer.

## Instructions

### 1. Check for staged changes

Run `git diff --staged --stat` to see if there are staged changes:
- If staged changes exist, proceed to analyze them
- If no staged changes, check for unstaged changes

### 2. If no staged changes, check unstaged

Run `git diff --stat` to see unstaged changes:
- If unstaged changes exist, ask user how to proceed using AskUserQuestion:
  - "Stage all changes and commit"
  - "Select specific files to stage"
  - "Cancel - stage manually first"

If user selects "all changes": run `git add -A`
If user selects "specific files": ask which files/patterns to stage, then run `git add` for those

### 3. Read the changed files

**Critical step**: Actually read the content of changed files to understand what changed.

Get the list of staged files:
```bash
git diff --staged --name-only
```

For each changed file (or the most important ones if many files):
- Use the Read tool to read the file
- Use `git diff --staged [file]` to see what specifically changed

### 4. Analyze the changes

Determine the nature of changes:
- **New files** → "Add [feature/component]"
- **Bug fixes** → "Fix [issue description]"
- **Feature updates** → "Update [component] to [behavior]"
- **Refactoring** → "Refactor [component]"
- **Documentation** → "Add/Update docs for [topic]"
- **Tests** → "Add tests for [component]"
- **Configuration** → "Configure [setting/tool]"

### 5. Check existing commit style

Run `git log -5 --oneline` to see the repository's commit message style:
- Does it use conventional commits (feat:, fix:, etc.)?
- Does it use imperative mood?
- What's the typical length?

Match the existing style.

### 6. Generate commit message

Create a commit message that:
- **First line**: Under 72 characters, summarizes the "why"
- **Follows repo style**: Match existing commit patterns
- **Is specific**: Based on actual file content, not just file names
- **Uses imperative mood**: "Add", "Fix", "Update", not "Added", "Fixed"

### 7. Handle -m override

If user provided `-m 'message'` argument:
- Use their message directly instead of generating one
- Still stage files if needed

### 8. Create the commit

Run the commit **without Co-Authored-By footer**:
```bash
git commit -m "Your generated message"
```

### 9. Show result

After commit succeeds:
- Show the commit hash and message
- Show `git status` to confirm clean state
- Offer to push if there's a remote

## Example Flows

### Flow 1: Staged changes exist

```
User: /commit

1. git diff --staged --stat → shows 3 files changed
2. git diff --staged --name-only → src/auth.ts, src/user.ts, tests/auth.test.ts
3. Read files + git diff --staged for each
4. Analyze: new auth validation function added, tests added
5. git log -5 --oneline → repo uses conventional commits
6. Generate: "feat(auth): add input validation for user registration"
7. git commit -m "feat(auth): add input validation for user registration"
8. Show: "Committed abc1234: feat(auth): add input validation..."
```

### Flow 2: No staged changes

```
User: /commit

1. git diff --staged --stat → empty
2. git diff --stat → shows 2 files modified
3. Ask: "No staged changes. Would you like to:"
   - "Stage all changes and commit"
   - "Select specific files"
   - "Cancel"
4. User: "Stage all"
5. git add -A
6. Continue with normal flow...
```

### Flow 3: Override message

```
User: /commit -m "Quick fix for login bug"

1. git diff --staged → check for staged changes
2. (Stage files if needed)
3. git commit -m "Quick fix for login bug"
4. Show result
```

## Important Notes

- **No Co-Authored-By footer**: This command intentionally omits the Claude footer
- **Read actual content**: Don't just look at file names - read the changes
- **Match repo style**: Check git log before generating message
- **Ask before staging**: Always ask user permission before staging files
