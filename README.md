# Reading List Manager

A Ruby on Rails app to manage a personal reading list.
Users can add books, edit them, delete them, and browse with search, sorting, and pagination.

## Live Demo
- https://reading-list-manager.onrender.com/books

## Features
- Books CRUD (create, read, update, delete)
- Search + filters (Ransack)
- Sorting
- Pagination (Pagy)
- Bootstrap UI
- Automated tests + GitHub Actions CI

## Tech Stack
- Ruby on Rails
- PostgreSQL
- Bootstrap
- GitHub Actions (CI)
- Render (deployment)

## Local Setup

### Requirements
- Ruby (via rbenv/rvm)
- PostgreSQL
- Node + npm

### Install
```bash
bundle install
npm install
bin/rails db:create db:migrate db:seed
bin/dev
```

### App runs at:
- http://localhost:3000

### Run Tests
- bin/rails test

### Notes
- Render free tier can spin down after inactivity and take time to “wake up”.



