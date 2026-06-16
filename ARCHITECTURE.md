# Jarvis Architecture — How It Works

## Core Concept

**Jarvis is the operating system for specialized AI agents.**

Unlike monolithic AI systems, Jarvis separates:
- **OS Layer (Core)** — Unified agent personality, reasoning, memory patterns
- **Brain Layer (Your Knowledge)** — SecondBrain (PARA-structured knowledge base)
- **Tools Layer (MCPs)** — Pluggable capabilities for specific domains

This allows you to spawn specialized agent **variants** (personal, family, business) that share the same core OS but have different brains and tool compositions.

## System Design

```
┌─────────────────────────────────────────────┐
│         Jarvis Agent Instance               │
├─────────────────────────────────────────────┤
│                                             │
│  ┌──────────────────────────────────────┐  │
│  │  Agent OS (Core Jarvis)              │  │
│  │  ├── SOUL.md personality             │  │
│  │  ├── Memory/knowledge architecture   │  │
│  │  ├── Reasoning patterns              │  │
│  │  └── Interaction style               │  │
│  └──────────────────────────────────────┘  │
│                    ↓                        │
│  ┌──────────────────────────────────────┐  │
│  │  SecondBrain (Knowledge Layer)       │  │
│  │  ├── Projects (active work)          │  │
│  │  ├── Areas (responsibilities)        │  │
│  │  ├── Resources (reference)           │  │
│  │  └── Archives (completed)            │  │
│  └──────────────────────────────────────┘  │
│                    ↓                        │
│  ┌──────────────────────────────────────┐  │
│  │  MCPs (Tools & Integrations)         │  │
│  │  ├── Core MCPs (Bash, GitHub, etc.)  │  │
│  │  └── Variant MCPs (domain-specific)  │  │
│  └──────────────────────────────────────┘  │
│                                             │
└─────────────────────────────────────────────┘
         ↓
    Docker Container
         ↓
    Multi-Agent System
```

## Key Layers

### 1. Agent OS (Core Jarvis)

The **core Jarvis OS** is stable, version-controlled, and shared across all variants.

**Defines:**
- Personality (SOUL.md) — How the agent thinks, communicates, values
- Memory structure — How knowledge is organized and retrieved
- MCP composition patterns — How to wire tools
- Lifecycle — How agent instances are created, updated, scaled

**Updated:**
- Rarely (major versions) — Core OS updates benefit all variants
- Weekly (learning sync) — Patterns from usage flow back to improve the OS

### 2. SecondBrain (Knowledge Layer)

Each agent instance has its own **SecondBrain** — an isolated knowledge base using PARA:

- **Projects** — Active, time-bound work
- **Areas** — Ongoing responsibilities without deadlines
- **Resources** — Reference material, documentation, learnings
- **Archive** — Completed projects and lessons learned

**Ownership:**
- Agent reads from brain (learns from your knowledge)
- You write to brain (teach the agent)
- Both update together via weekly sync

### 3. MCPs (Tool Layer)

**Pluggable, domain-specific capabilities** that vary by agent variant.

**Core MCPs (all agents):**
- Bash — Execute commands, manage system
- GitHub — Read/write repos, PRs, issues
- File system — Read/write local files

**Variant MCPs (specialized):**
- **Personal Jarvis** → Google Workspace, personal calendar, private projects
- **Family Adviser** → Shared Google Docs, family calendar, governance tracking
- **Business Adviser** → Project management tools, CRM, analytics

## Agent Lifecycle

### Creation

```bash
# 1. Clone Jarvis (gets core OS)
git clone https://github.com/robinkwee/jarvis.git

# 2. Choose variant
cp -r variants/personal-assistant my-agent

# 3. Point to your brain
export BRAIN_PATH=/path/to/your/secondbrain

# 4. Deploy
docker-compose up -d
```

### Daily Operation

```
Agent Instance
├── Reads SecondBrain (learns)
├── Processes tasks via MCPs (acts)
├── Updates SecondBrain (teaches)
└── Logs learnings for weekly sync
```

### Weekly Learning Sync

```
SecondBrain (your knowledge)
    ↓
Jarvis Repo (core OS improves)
    ↓
Next agent instance (inherits improvements)
```

## Multi-Agent Coordination

When multiple Jarvis variants run on your VPS:

```
┌────────────────────────────────────┐
│     Your Hostinger VPS             │
├────────────────────────────────────┤
│                                    │
│  ┌──────────────┐  ┌────────────┐ │
│  │ Jarvis       │  │ KweeFamily │ │
│  │ (Personal)   │  │ Adviser    │ │
│  ├──────────────┤  ├────────────┤ │
│  │ Brain: yours │  │ Brain:     │ │
│  │ MCPs: 8+     │  │ family     │ │
│  │ RAM: 2GB     │  │ MCPs: 4+   │ │
│  │              │  │ RAM: 1.5GB │ │
│  └──────────────┘  └────────────┘ │
│                                    │
│  ┌──────────────────────────────┐ │
│  │ Nginx (reverse proxy)        │ │
│  │ Routes traffic to agents     │ │
│  └──────────────────────────────┘ │
│                                    │
│  ┌──────────────────────────────┐ │
│  │ Shared Services              │ │
│  │ ├── Docker daemon            │ │
│  │ ├── GitHub sync cron job     │ │
│  │ └── Learning sync pipeline   │ │
│  └──────────────────────────────┘ │
│                                    │
└────────────────────────────────────┘
```

**Key:**
- Each agent isolated in container (own filesystem, memory, config)
- Shared core OS (all benefit from improvements)
- Separate brains (each has its own knowledge)
- Orchestrator (Jarvis) routes tasks to right agent variant

## Evolution & Learning

### Single-Run Learning
```
Agent processes task
    ↓
Learns from it (logs to SecondBrain)
    ↓
Next task builds on that knowledge
```

### Weekly Sync Learning
```
SecondBrain (1 week of learnings)
    ↓
Analysis → Extract patterns → Update SOUL.md patterns
    ↓
Commit to Jarvis GitHub repo
    ↓
Next agent spin-up inherits improvements
```

### Community Learning
```
Your improvements to Jarvis
    ↓
Push to GitHub (open-source)
    ↓
Others fork + benefit from your learnings
    ↓
Community contributes back
```

## Deployment Scenarios

### 1. Single Agent (Local/VPS)
```bash
docker-compose -f variants/personal-assistant/docker-compose.yml up -d
# One agent on your machine
```

### 2. Multi-Agent (Your VPS)
```bash
docker-compose up -d
# 2-3 agents running in parallel, each isolated
```

### 3. Multi-Cloud
```bash
# Deploy personal-assistant on AWS
# Deploy family-adviser on your VPS
# Deploy business-adviser on DigitalOcean
# All share same core OS, different brains
```

## Security & Privacy

### Core OS (Open Source)
- ✅ Public GitHub repo
- ✅ MIT licensed
- ✅ No secrets embedded
- ✅ Reusable by community

### SecondBrain (Private)
- ✅ Your knowledge stays yours
- ✅ Git-backed (pull/push to your private repo)
- ✅ Agent reads only; you control writes
- ✅ Weekly sync is optional/configurable

### Agent Instance
- ✅ Containerized (isolated from host)
- ✅ Resource-limited (CPU/memory)
- ✅ Configurable MCPs (you choose tools)
- ✅ Read secrets from .env (not in code)

## Extending Jarvis

### Add a New Variant
```bash
# 1. Clone your agent
cp -r variants/personal-assistant variants/my-specialty-agent

# 2. Customize SOUL.md (personality)
# 3. Update MCPs (tools needed)
# 4. Point to specialized brain
# 5. Deploy
```

### Improve Core OS
```bash
# 1. Run agent, notice pattern
# 2. Update core/ files (SOUL patterns, memory-system, etc.)
# 3. Test with all variants
# 4. Push to GitHub (weekly sync or manual)
# 5. All future agents inherit improvement
```

### Contribute Back
```bash
# Fork Jarvis
# Improve core OS
# Submit PR
# Community benefits
```

---

**Jarvis is designed to be your agent OS.** Fork it, customize it, improve it, share it.
