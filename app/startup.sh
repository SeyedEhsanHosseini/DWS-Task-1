#!/bin/bash
gunicorn -b 0.0.0.0:8000 --worker-class eventlet --access-logfile - --error-logfile - "app:app"
