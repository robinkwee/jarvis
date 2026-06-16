# GeniBot on Telegram — Setup Guide

**Deploy GeniBot as a full AI agent on Telegram.**

Robin talks with GeniBot about GENAIO strategy. Partner gets their own instance. Real conversations, intelligent responses.

---

## Prerequisites

- ✅ Telegram bot token (you have: `8606382447:AAEi655G6eOtl5164O4bB_Q7uE1Uop4mihA`)
- ✅ VPS with OpenClaw running (port 18789)
- ✅ Domain with HTTPS (for webhook)
- ✅ GeniBot brain files created in `brain/`

---

## Step 1: Get Telegram User IDs

Message @userinfobot in Telegram, get:
- **Your ID** (Robin)
- **Partner's ID**

Save these for `.env.telegram`.

---

## Step 2: Configure Telegram Environment

Edit `.env.telegram` in the genaio-bot folder:

```bash
nano /home/robin/jarvis/variants/genaio-bot/.env.telegram
```

Fill in:
```env
TELEGRAM_BOT_TOKEN=8606382447:AAEi655G6eOtl5164O4bB_Q7uE1Uop4mihA
TELEGRAM_WEBHOOK_URL=https://your-vps-domain.com/genaio-bot/telegram
ADMIN_TELEGRAM_ID=123456789
PARTNER_TELEGRAM_ID=987654321
GENAIO_BRAIN_PATH=/home/robin/jarvis/variants/genaio-bot/brain
```

---

## Step 3: Deploy GeniBot Agent on VPS

SSH into your VPS:

```bash
# Clone or update Jarvis repo
cd /home/robin/jarvis/variants/genaio-bot

# Load environment
export $(cat .env.telegram | grep -v '^#' | xargs)

# Start GeniBot as full agent
# (Instead of the simple HTTP server)
openclaw agent \
  --name "GeniBot" \
  --config agent-config.yml \
  --brain-path $GENAIO_BRAIN_PATH \
  --port 8003 \
  --telegram-token $TELEGRAM_BOT_TOKEN \
  --telegram-webhook $TELEGRAM_WEBHOOK_URL
```

Or use Docker (recommended):

```bash
# Update docker-compose.yml to use Claude agent image
sed -i 's|image: python:3.11-slim|image: claude-agent:latest|' docker-compose.yml

# Start container
docker compose up -d

# Verify
docker compose logs -f genaio-bot
# Should show: "[Telegram] Webhook registered" and "[Agent] GeniBot ready"
```

---

## Step 4: Set Up Webhook with Telegram

Register your webhook with Telegram:

```bash
curl -X POST \
  https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/setWebhook \
  -H "Content-Type: application/json" \
  -d "{\"url\": \"${TELEGRAM_WEBHOOK_URL}\"}"

# Response should show: "ok": true
```

---

## Step 5: Test with Telegram

Message your bot on Telegram:

```
You: "What's our current roadmap?"

GeniBot: 
  [reads brain → 1-Projects/GENAIO/Roadmap.md]
  
  "Based on your brain, here's the current roadmap:
  
  Q2 2026:
  - Feature X (in progress)
  - User research (completed)
  
  Q3 2026:
  - Feature Y (planned)
  - Launch prep
  
  Next: Update with latest design decisions."
```

---

## Step 6: Share with Partner

Partner sets up their own instance:

```bash
git clone https://github.com/robinkwee/jarvis.git
cd jarvis/variants/genaio-bot
nano .env.telegram
# Partner fills in:
# - Their own telegram ID
# - Their own brain path (or shared)
# - Same webhook URL (or their own)

docker compose up -d
```

**Both instances run independently** but share the Jarvis core, so improvements to GeniBot help both.

---

## Example Conversations

### Strategy Discussion

```
You: "What are our biggest risks for launch?"

GeniBot:
  [reads: Vision.md, Launch-Plan.md, Market-Analysis.md]
  
  "Based on your docs, I see 3 risks:
  
  1. **Timeline** — Design sign-off delayed
  2. **Market** — Competitor X launching similar feature
  3. **Resources** — Marketing budget unclear
  
  I'd prioritize: Get design sign-off this week,
  clarify budget, then reassess market moves.
  
  Want me to draft a risk mitigation plan?"
```

### Decision Making

```
You: "Should we launch on Aug 1 or wait for feature X?"

GeniBot:
  [reads: Roadmap.md, Feature specs, Launch-Plan.md]
  
  "Recommendation: Launch Aug 1 without Feature X.
  
  Why:
  - Feature X won't be ready (design: 3wks, dev: 5wks)
  - Aug 1 aligns with marketing campaign (already committed)
  - You can add Feature X in v1.1 (2-week cadence)
  
  Next: Update Launch-Plan.md with decision + rationale."
```

### Progress Tracking

```
You: "Status update"

GeniBot:
  [reads: Milestones.md, recent docs]
  
  "GENAIO Progress:
  
  ✅ Completed:
  - Brand strategy (approved by partner)
  - Initial user research
  
  🔄 In Progress:
  - Design mockups (80% done)
  - Technical architecture
  
  ⏳ Blocked:
  - Marketing copy (awaiting brand approval)
  
  Next: Approve brand, unblock marketing."
```

---

## Troubleshooting

### "Webhook not responding"

```bash
# Verify webhook URL is HTTPS and accessible
curl https://your-vps-domain.com/genaio-bot/telegram

# Should return 200 OK
# If 404, check nginx reverse proxy config
```

### "Bot not responding to messages"

```bash
# Check logs
docker compose logs genaio-bot

# Verify token is correct
curl https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/getMe

# Should return bot info
```

### "Agent timeout on large queries"

```bash
# Increase timeout in agent-config.yml
# Or split query: "Summarize roadmap" → "What's Q3?"
```

---

## Architecture

```
Telegram (Phone)
    ↓ (message)
Telegram API
    ↓ (webhook)
VPS (port 8003)
    ↓
GeniBot Agent
    ├── Claude reasoning (opus-4-8)
    ├── Brain search (Roadmap.md, etc.)
    └── Response generation
    ↓ (answer)
Telegram API
    ↓
You & Partner
```

---

## Costs & Resources

- **Claude API**: ~$0.01 per query (depending on brain size)
- **VPS**: 1GB RAM (already reserved for GeniBot)
- **Telegram**: Free

---

## Next Steps

1. ✅ Fill in `.env.telegram`
2. ✅ Deploy on VPS
3. ✅ Register webhook
4. ✅ Test with Telegram
5. ✅ Share with partner
6. ✅ Add more brain docs as you work on GENAIO

---

## Commands

```bash
# Start
docker compose up -d

# Logs
docker compose logs -f genaio-bot

# Stop
docker compose down

# Check health
curl http://localhost:8003/health
```

---

**GeniBot is now your Telegram collaborator for GENAIO.** 🚀
