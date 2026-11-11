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

### Post patterns

**Collapsible document block** (styled after Robin Sloan's `VISION.md`): use for a long quoted doc, brief, or prompt that would interrupt the flow of a post. Styles live in `details.vision-doc` in `assets/styles/post-styles.scss`. The `markdown="1"` attribute is required so kramdown renders markdown inside the element, and the blank lines around the body are required too. Collapsed, it shows the filename plus a light grey "expand to read more" hint.

```markdown
<details class="vision-doc" markdown="1">
<summary>DESIGN.md</summary>

Body text, lists, and **bold** all render as markdown.

- **One.** First point.
- **Two.** Second point.

</details>
```

**Image paginator**: a click-through set of images with captions, prev/next buttons, a counter, arrow keys (when focused), and swipe. Styles are `.paginator` in `assets/styles/post-styles.scss`; behavior is `assets/js/paginator.js`. Add the script tag once per post, after the last paginator. Each `<figure>` is one slide; keep the HTML unindented so kramdown does not treat it as a code block. The frame is a fixed 7:4 box and images scale to fill it (`object-fit: cover`), so use images close to that shape or expect slight edge cropping.

```html
<div class="paginator" tabindex="0">
<figure><img src="/assets/img/posts/<post>/one.png" alt="..."><figcaption>Caption one.</figcaption></figure>
<figure><img src="/assets/img/posts/<post>/two.png" alt="..." loading="lazy"><figcaption>Caption two.</figcaption></figure>
</div>
<script src="/assets/js/paginator.js" defer></script>
```

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
