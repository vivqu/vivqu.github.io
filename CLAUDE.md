# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Install dependencies
bundle install

# Serve locally with live reload
jbundle
```

## Testing

Use `playwright-cli` for browser-based testing. Save screenshots to `.screenshot-tests/` (gitignored):

```bash
playwright-cli screenshot --filename=.screenshot-tests/page.png
```

## Architecture

This is a **Jekyll 3.9** static site deployed to GitHub Pages at vivqu.com.

### Content types

- **Blog posts**: Markdown files in `_posts/` with frontmatter fields: `title`, `published`, `tags`, `read_time`, `seo_description`, `source` (bool for external source posts), `subtitle`
- **Tags**: Each tag has a corresponding file in `_tags/` and a URL at `/tags/<tagname>/`
- **Books**: Custom section under `books/` with sub-pages (e.g. `books/autumn/`, `books/japan_guide/`)
- **Static pages**: `index.html`, `blog.html`, `about.html`, `archive.html`, `tags.html`, etc.

### Layout hierarchy

`default.html` → extended by `post.html`, `blog.html`, `home.html`, etc. Layouts use a two-column structure: a left sidebar (masthead with bio/nav) and a right content area.

### Styling

- Main styles in `assets/styles/styles.scss` and `assets/styles/post-styles.scss`
- Sass partials in `_sass/`: `_variables.scss`, `_fonts.scss`, `_autumn.scss`, `_highlight-syntax.scss`
- Japan guide has its own stylesheet: `assets/styles/japan.scss`
- Uses GitHub Primer CSS classes (e.g. `d-md-flex`, `border-md-right`, `px-4`, `text-gray`)

### Data files

- `_data/bio.yml`: Header name/description shown in sidebar
- `_data/social_media.yml`: Social links
- `_data/colors.json`: Color definitions used across the site

### Key configuration (`_config.yml`)

- Default layout for posts: `post`
- Permalink format: `/blog/:year/:month/:day/:title/`
- Tags collection outputs pages at `tags/:path/`
- Plugins: `jekyll-octicons`, `jekyll-feed`, `jekyll-last-modified-at`
