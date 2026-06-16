# GeniBot — GENAIO Project Assistant

**A creative, strategic partner for the GENAIO.org project.**

Dedicated to:
- 🎯 **Strategy** — Product vision, roadmap, positioning
- 🎨 **Brand & Creative** — Identity, messaging, design direction
- 📋 **Project Management** — Tracking, milestones, timelines
- 💡 **Problem-Solving** — Brainstorm solutions collaboratively
- 👥 **Partner Coordination** — Keep Robin and his partner aligned
- 🚀 **Launch Planning** — Go-to-market, launch coordination

---

## Quick Start (Local Docker)

### 1. Clone & Setup

```bash
cd /home/robin/jarvis/variants/genaio-bot

# Make startup script executable
chmod +x start.sh

# Start the container
./start.sh start
```

### 2. Verify It's Running

```bash
./start.sh status

# Output:
# NAME          IMAGE          COMMAND  PORTS
# genaio-bot    python:3.11... running  0.0.0.0:8003->8000/tcp
```

### 3. Access Your Brain

```bash
# List all project contents
curl http://localhost:8003/

# View project docs
curl http://localhost:8003/1-Projects/GENAIO/

# View logs
./start.sh logs -f
```

---

## Startup Script

Easy container management:

```bash
./start.sh start       # Start the container
./start.sh stop        # Stop the container
./start.sh restart     # Restart
./start.sh status      # Show status & memory
./start.sh logs -f     # Watch live logs
./start.sh brain       # List all project files
./start.sh shell       # Open bash in container
./start.sh clean       # Remove container (brain preserved)
./start.sh help        # Show all commands
```

---

## Brain Structure

GeniBot reads from your GENAIO brain, organized as PARA:

```
brain/
├── 1-Projects/
│   └── GENAIO/
│       ├── Vision.md              # GENAIO vision & mission
│       ├── Roadmap.md             # Product roadmap
│       ├── Brand-Strategy.md      # Brand identity, messaging
│       ├── Market-Analysis.md     # Competitive landscape
│       └── Launch-Plan.md         # Go-to-market strategy
│
├── 2-Areas/
│   ├── Product-Strategy.md        # Product decisions, features
│   ├── Design-Direction.md        # UI/UX, design system
│   ├── Partnership.md             # Collaboration with partner
│   ├── Marketing.md               # Messaging, campaigns, content
│   └── Milestones.md              # Timeline, deadlines, tracking
│
├── 3-Resources/
│   ├── GENAIO-Links.md            # Important URLs, references
│   ├── Team-Contacts.md           # Team members, roles
│   ├── Decision-Log.md            # Past decisions & rationale
│   └── Inspiration.md             # Competitive products, inspiration
│
└── 4-Archive/
    ├── Completed-Milestones/      # Finished launches, phases
    └── Historical-Decisions/      # Archived decisions
```

---

## Sharing with Your Partner

### Option 1: Fork the Jarvis Repo

Your partner forks the main Jarvis repo:
```bash
git clone https://github.com/[partner-github]/jarvis.git
cd jarvis/variants/genaio-bot
./start.sh start
```

### Option 2: Separate GENAIO Brain

Keep the Jarvis framework shared, but use separate brains:

**Your setup:**
```bash
export GENAIO_BRAIN_PATH=/home/robin/SecondBrain/GENAIO
./start.sh start
```

**Partner's setup:**
```bash
export GENAIO_BRAIN_PATH=/home/partner/GENAIO-Brain
./start.sh start
```

Both run GeniBot on their machines, same bot, different brains.

### Option 3: Shared GitHub Repo

Create a private GitHub repo for the GENAIO brain:
```bash
# Robin pushes his brain
git clone https://github.com/robinkwee/genaio-brain.git
cd genaio-brain
# Add/commit project docs
git push

# Partner pulls and works
git clone https://github.com/robinkwee/genaio-brain.git
# Same brain, both contribute
```

---

## Deployment

### Local (Development)

```bash
# Your machine
./start.sh start
# GeniBot running on localhost:8003

# Your partner's machine
./start.sh start
# GeniBot running on localhost:8003
```

### Production VPS

When ready to deploy on your 8GB VPS:

```bash
# Deploy all variants together
# Personal Jarvis: port 8000, 2GB
# GeniBot: port 8003, 1GB
# Plus buffer for OpenClaw gateway

# All run via docker compose
cd /home/robin/jarvis
docker compose -f variants/personal-assistant/docker-compose.yml up -d
docker compose -f variants/genaio-bot/docker-compose.yml up -d

# Both accessible
curl http://localhost:8000/         # Personal Jarvis
curl http://localhost:8003/         # GeniBot
```

---

## Workflow Example

### Planning Session

```
You: "Create a 6-month roadmap for GENAIO launch"
GeniBot:
  → Reads Vision.md, Market-Analysis.md
  → Generates roadmap outline
  → Suggests milestones & timelines
  → Output to Roadmap.md

You & Partner: Review together
  → Edit roadmap
  → Add partner feedback
  → Commit to brain

Next session: GeniBot reads updated roadmap, builds on it
```

### Launch Coordination

```
You: "What are the blockers to launch next month?"
GeniBot:
  → Scans all 1-Projects/GENAIO/ docs
  → Checks Milestones.md status
  → Reviews Partnership.md for alignment
  → Lists blockers with impact

You: "Update: Designer approved final mockups"
GeniBot:
  → Updates Design-Direction.md
  → Removes blocker
  → Suggests next steps
  → Notifies via weekly summary
```

---

## Memory & Learning

GeniBot starts fresh each session but learns from your brain:
- **You teach** — Update brain with decisions, learnings, updates
- **GeniBot reads** — Absorbs knowledge from brain
- **You collaborate** — Iterate together with feedback

Weekly sync (if enabled) pushes GeniBot learnings back to the Jarvis framework.

---

## Troubleshooting

### Container Won't Start

```bash
# Check Docker
docker ps

# Check logs
./start.sh logs

# Common issues:
# - Brain path doesn't exist → Create it or fix GENAIO_BRAIN_PATH
# - Port 8003 in use → Change PORT in start.sh
# - Permission denied → Run: newgrp docker
```

### Brain Not Showing

```bash
# Verify brain is mounted
docker exec genaio-bot ls -la /brain/secondbrain

# Check permissions
ls -la brain/
```

---

## Next Steps

1. ✅ **Structure created** — Directory & startup script ready
2. ⏳ **Add project docs** — Create Vision.md, Roadmap.md, etc.
3. ⏳ **Start locally** — Test with `./start.sh start`
4. ⏳ **Share with partner** — Fork or share brain repo
5. ⏳ **Deploy to VPS** — Run alongside Personal Jarvis

---

## Resources

- [Main Jarvis README](../../README.md) — Overview of framework
- [ARCHITECTURE.md](../../ARCHITECTURE.md) — System design
- [CONTRIBUTING.md](../../CONTRIBUTING.md) — How to improve Jarvis
- [SOUL.md](./SOUL.md) — GeniBot's personality

---

**Ready to build GENAIO together.** 🚀
