# 👗 AI-Powered Digital Closet

An AI-driven wardrobe management system that classifies outfits, recommends clothing combinations, and adapts suggestions based on weather, personal style history, and event type.

![FastAPI](https://img.shields.io/badge/FastAPI-005571?logo=fastapi)
![AWS Lambda](https://img.shields.io/badge/AWS%20Lambda-FF9900?logo=awslambda)
![TensorFlow](https://img.shields.io/badge/TensorFlow-FF6F00?logo=tensorflow)
![React](https://img.shields.io/badge/React-20232A?logo=react)
![Redis](https://img.shields.io/badge/Redis-DC382D?logo=redis)

---

## ✨ Features
- **Real-Time Outfit Classification** — TensorFlow + FastAPI API with Redis caching (P99 latency <180 ms)
- **Smart Recommendations** — Blends AI vision model predictions with weather & calendar context
- **Responsive UI** — React.js frontend delivering instant AI suggestions
- **Serverless Deployment** — AWS Lambda for cost-efficient scaling
- **Weather Awareness** — Integrated with OpenWeather API for seasonal dressing

---

## 🏗 Architecture
![Architecture Diagram](architecture.png)

**Flow:**
1. User uploads clothing item via React frontend
2. FastAPI backend receives image → passes to TensorFlow model
3. Redis cache stores frequent results for faster inference
4. Recommendation engine blends classification + weather API data
5. Suggested outfits returned to frontend in real-time

---

## 🚀 Getting Started
### Backend Setup
```bash
git clone https://github.com/yourusername/ai-digital-closet
cd backend
pip install -r requirements.txt
uvicorn app.main:app --reload
