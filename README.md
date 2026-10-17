# Flask Cohere Chatbot

A simple web-based chatbot built with Flask and powered by the [Cohere](https://cohere.com/) AI API. Users can ask questions through a browser interface and receive AI-generated responses rendered in formatted Markdown. [Live Demo](https://hooman-chatbot.onrender.com)

## Features

- Clean web UI with a text input form
- Powered by Cohere's `command-a-03-2025` model
- Responses rendered as formatted Markdown (bold, lists, code blocks, etc.)
- CSRF protection via Flask-WTF

## Prerequisites

- Python 3.8+
- A [Cohere API key](https://dashboard.cohere.com/api-keys)

## Installation

1. **Clone the repository**

   ```bash
   git clone <your-repo-url>
   cd <your-repo-folder>
   ```

2. **Install dependencies**

   ```bash
   pip install flask flask-wtf cohere markdown
   ```

3. **Set your Cohere API key**

   Open `app.py` and replace the placeholder key with your own:

   ```python
   co = cohere.ClientV2('YOUR_API_KEY_HERE')
   ```

   > ⚠️ **Security note:** Avoid hardcoding API keys in source code. Use an environment variable instead:
   >
   > ```python
   > import os
   > co = cohere.ClientV2(os.environ.get('COHERE_API_KEY'))
   > ```
   >
   > Then set it in your shell: `export COHERE_API_KEY=your_key_here`

## Running the App

```bash
python app.py
```

Then open your browser and navigate to `http://127.0.0.1:5000`.

## Project Structure

```
├── app.py            # Flask application and route logic
└── templates/
    └── home.html     # Frontend UI template
```

## Usage

1. Type any question or message into the input field.
2. Click **Submit**.
3. The AI's response will appear below the form, formatted with Markdown.

## Dependencies

| Package | Purpose |
|---|---|
| `flask` | Web framework |
| `flask-wtf` | Form handling and CSRF protection |
| `cohere` | Cohere AI API client |
| `markdown` | Renders AI responses as HTML |

