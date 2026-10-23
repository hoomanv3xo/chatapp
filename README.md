# 💬 ChatApp: Real-Time Chat

A real-time chat application built with **Django**, **Django Channels** and **Daphne**. Users sign up, log in, and chat live over WebSockets.

![Screenshot of the app](chatapp-image.png)

## Features

- User sign-up and login (Django authentication)
- Live messaging over WebSockets, with messages broadcast to everyone in the chat
- ASGI server (Daphne) serving both HTTP pages and WebSocket connections
- Load-test script included to measure concurrent-connection behavior

## Tech Stack

Python · Django · Django Channels · Daphne (ASGI) · WebSockets · HTML/CSS

## Project Structure

```
chatapp/
├── manage.py
├── run.bat
├── README.md
├── requirements.txt
├── loadtest_chat.py          # WebSocket load-test script
├── chatapp/
│   ├── settings.py
│   ├── urls.py
│   ├── asgi.py
│   └── wsgi.py
└── chat/
    ├── consumers.py          # WebSocket consumer
    ├── routing.py            # WebSocket URL routes (ws/chat/)
    ├── urls.py               # HTTP URL routes
    ├── views.py              # Signup and chat views
    └── templates/
        ├── chat/chat.html
        └── registration/
            ├── login.html
            └── signup.html
```

## Getting Started

1. **Clone the repository**

   ```bash
   git clone https://github.com/hoomanv3xo/chatapp.git
   cd chatapp
   ```

2. **Install dependencies**

   ```bash
   pip install -r requirements.txt
   ```

3. **Create the database tables**

   ```bash
   python manage.py migrate
   ```

4. **Start the server**

   On Windows, double-click `run.bat`, or run Daphne directly:

   ```bash
   daphne -p 8000 chatapp.asgi:application
   ```

5. Open http://localhost:8000, create an account, log in, and open the chat page in a second browser or window to see messages arrive live.

## Load Testing

`loadtest_chat.py` opens many concurrent WebSocket clients that each send messages to the shared chat, then reports connections, delivery, and round-trip latency.

```bash
pip install "websockets>=13"
python loadtest_chat.py --url ws://localhost:8000/ws/chat/ --clients 50 --messages 5 --delay 10 \
    --cookie "sessionid=<your logged-in session cookie>"
```

The chat requires login, so copy the `sessionid` cookie from your browser's developer tools after logging in.

### Results

Tested locally on a single laptop, with the server and the test running on the same machine. All clients share one chat room and one login session. Each message is delivered to every connected client, so 50 clients sending 250 messages means 12,500 deliveries.

| Clients | Messages sent | Delivered | Dropped connections | Median latency | p95 latency |
|---|---|---|---|---|---|
| 10 | 100 | 1,000 / 1,000 | 0 | 33 ms | 81 ms |
| 50 | 250 | 12,500 / 12,500 | 0 | about 1,050 ms | about 2,300 ms |

**Takeaways**

- Every connection stayed up and every message was delivered in both runs.
- Latency grows with the number of connected clients, because each message is delivered to each of them. Under a heavy send rate (50 clients sending several times a second), the server fell behind and messages arrived seconds late.
- Next improvement: profile the consumer and the channel layer configuration to reduce per-message latency at higher client counts.

## Limitations

- A single shared chat room (no private rooms or direct messages)
- Load figures are from local testing, not a production deployment

## Disclaimer

Built as a learning project. Not intended for production use without further hardening.
