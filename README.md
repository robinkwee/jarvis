# Jarvis — Open-Source AI Agent Framework

**Jarvis** is a reusable, containerized AI agent framework for building specialized assistants with isolated knowledge bases and tool compositions.

## What is Jarvis?

Jarvis is the **operating system** for AI agents. It provides:
- 🧠 **Core Agent OS** — Unified personality, reasoning, memory system
- 🧠 **Isolated Brains** — Each agent has its own SecondBrain (knowledge base)
- 🔌 **Pluggable MCPs** — Compose tools based on agent purpose
- 📦 **Docker-Ready** — Containerized, multi-agent deployment
- 🔄 **Continuously Evolving** — Framework learns and improves from real usage

## Quick Start

### 1. Clone Jarvis
```bash
git clone https://github.com/robinkwee/jarvis.git
cd jarvis
```

### 2. Choose Your Variant
Pick a template based on your use case:
- **personal-assistant** — Your own Jarvis (reasoning, coding, research)
- **family-adviser** — Family knowledge & governance
- **business-adviser** — Work projects & strategy
- Start fresh with **core/** templates

### 3. Deploy
```bash
docker-compose -f variants/personal-assistant/docker-compose.yml up -d
```

### 4. Connect Your Brain
Point your agent to your SecondBrain:
```bash
export BRAIN_PATH=/path/to/your/secondbrain
docker-compose up -d
```

## Architecture

```
Jarvis Framework
├── core/
│   ├── agent-base/          # Core Jarvis "OS"
│   │   ├── SOUL.md          # Personality blueprint
│   │   ├── memory-system/   # How to structure brains
│   │   └── mcp-composition/ # Tool wiring patterns
│   └── docker-compose.template.yml
│
├── variants/                # Ready-to-use agent archetypes
│   ├── personal-assistant/  # Your own Jarvis
│   ├── family-adviser/      # Family governance & decisions
│   └── business-adviser/    # Work & projects
│
└── examples/
    ├── brain-structure/     # How to organize SecondBrain
    ├── mcp-setups/          # Tool composition examples
    └── deployment-guide.md  # Production checklist
```

## Key Concepts

### Agent OS (Core)
The **core Jarvis OS** is stable and shared across all variants. It defines:
- How the agent thinks and reasons
- Memory/knowledge architecture
- Tool integration patterns
- Deployment lifecycle

Think of it like Linux — the kernel stays the same, but you can run different apps on top.

### SecondBrain (Your Knowledge)
Each agent needs a **SecondBrain** — your personal knowledge base organized with PARA:
- **Projects** — Active work
- **Areas** — Ongoing responsibilities
- **Resources** — Reference material
- **Archive** — Completed work

Your brain is **yours**. Jarvis just reads it.

### MCP Composition
Each agent wires up different tools (MCPs):
- **Personal Jarvis** → Bash, GitHub, Claude API, personal calendar
- **Family Adviser** → Google Workspace, family decision tracking
- **Business Adviser** → Project management, CRM, analytics

## Deployment

### Local Docker (2 min setup)
```bash
docker-compose up -d
# Agent runs on localhost:8000
```

### VPS Multi-Agent (4 agents on 8GB RAM)
See `/examples/deployment-guide.md` for:
- Docker Compose orchestration
- Resource allocation (CPU/memory per agent)
- Nginx reverse proxy setup
- WhatsApp/Telegram integration

### Cloud (AWS/GCP/Azure)
Containerized → Cloud-native. Use your favorite orchestrator (Kubernetes, etc.).

## Continuous Evolution

Jarvis learns and improves. Changes flow back to the framework:

```
Your Usage → Learnings → Weekly Sync → GitHub
     ↓
Everyone benefits from your discoveries
```

See `CONTRIBUTING.md` for how to contribute improvements.

## License

MIT — Fork, modify, share. Keep the learning loop open.

## Who's Using Jarvis?

- **Robin** — Personal assistant + family governance bot
- **Your Name Here** → Fork + customize!

## Learn More

- [ARCHITECTURE.md](ARCHITECTURE.md) — Deep dive into how Jarvis works
- [CONTRIBUTING.md](CONTRIBUTING.md) — How to improve Jarvis
- [variants/](variants/) — Ready-to-use agent templates
- [examples/](examples/) — Deployment & setup guides

---

**Questions?** Open an issue or start a discussion. Jarvis is built by the community, for the community.
