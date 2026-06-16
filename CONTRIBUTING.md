# Contributing to Jarvis

**Jarvis evolves through community contributions.** If you've improved Jarvis or discovered a pattern that works, share it back so others benefit.

## How to Contribute

### 1. Improving Core OS

If you've discovered a better personality pattern, memory structure, or reasoning approach:

1. **Describe the improvement** — Open an issue or PR with:
   - What you changed
   - Why it's better (measured improvement, user feedback, cleaner logic)
   - How to test it

2. **Test with all variants** — Ensure your change works for personal, family, and business agents

3. **Submit PR** → We'll review and merge

### 2. Building a New Variant

If you've built a specialized agent (e.g., "investor-adviser", "health-coach"):

1. **Structure it like existing variants:**
   ```
   variants/your-agent/
   ├── SOUL.md
   ├── docker-compose.yml
   ├── mcp-config.json
   ├── brain-template/        # Example SecondBrain structure
   │   ├── 1-Projects/
   │   ├── 2-Areas/
   │   ├── 3-Resources/
   │   └── 4-Archive/
   └── README.md             # How to use this variant
   ```

2. **Document it:**
   - SOUL.md explaining the agent's personality and purpose
   - README.md with quick start
   - Example brain structure for users to fork

3. **Submit PR** → We'll review and showcase it in the main README

### 3. Contributing Tools & MCPs

If you've integrated a new tool (Slack, Linear, Stripe):

1. **Create an MCP example:**
   ```
   examples/mcp-setups/your-tool/
   ├── mcp-config.json
   ├── docker-compose.override.yml
   └── README.md            # Integration guide
   ```

2. **Document the integration**
   - What the tool does
   - How to authenticate
   - Example use cases

3. **Submit PR**

### 4. Fixing Bugs or Issues

Found a problem?

1. **Open an issue** — Describe what broke and how to reproduce it
2. **Fix it** → PR with the fix
3. **Test** → Include steps to verify the fix works

## Development Workflow

### Setup

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/jarvis.git
cd jarvis

# Create a feature branch
git checkout -b feature/my-improvement

# Make your changes
# Test them locally
```

### Code Standards

- **No secrets** — Never commit API keys, passwords, or sensitive configs
- **Document changes** — Update README/ARCHITECTURE if you change how things work
- **Keep core stable** — Core Jarvis OS changes should be backward compatible
- **Test variants** — Changes should work across personal, family, and business agents

### Testing

```bash
# Test your variant locally
docker-compose -f variants/personal-assistant/docker-compose.yml up -d

# Verify it works
# (depends on your change — API calls, file writes, etc.)

# Bring down when done
docker-compose down
```

### Commit & PR

```bash
git add .
git commit -m "Feature: what you did

- Bullet point explaining why
- Another point if complex

This improves X by doing Y."

git push origin feature/my-improvement
```

Then open a PR on GitHub with:
- **Title** — Clear, short (50 chars max)
- **Description** — Why this change, how it works, what's tested
- **Before/after** — If visual or behavioral, show the difference

## Contribution Ideas

### Low effort, high impact:
- Fix typos or improve documentation
- Add a new example in `examples/`
- Improve Docker Compose templates
- Share your brain structure (anonymized)

### Medium effort:
- New MCP setup example
- Improve memory system patterns
- Better error messages
- Expanded SOUL patterns

### High effort, high value:
- New agent variant (investor, researcher, therapist, etc.)
- New tool integration
- Performance improvements
- Security hardening

## Releases & Versioning

Jarvis uses [Semantic Versioning](https://semver.org/):
- **0.1.x** — Early development, breaking changes OK
- **1.0.0+** — Stable API, breaking changes rare

We cut releases when:
- New variant is production-ready
- Core OS improvements are substantial
- Community contributions accumulate

## Code of Conduct

- **Respectful** — Be kind to contributors
- **Inclusive** — Welcome all skill levels
- **Helpful** — Assume good intent
- **Safe** — No spam, abuse, or harassment

## Questions?

- 💬 Open a discussion for ideas
- 🐛 Open an issue for bugs
- 💡 Check existing PRs before duplicating work
- 📖 Read ARCHITECTURE.md for deep dives

---

**Thank you for making Jarvis better.** Every contribution, no matter how small, helps the community. 🚀

