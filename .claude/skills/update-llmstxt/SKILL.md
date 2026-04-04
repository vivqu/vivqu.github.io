---
name: update-llmstxt
description: Sync llms.txt blog posts section with all posts in _posts/, adding missing entries with descriptive blurbs.
allowed-tools: Glob Grep Read Edit
---

# Update llms.txt

Keep `llms.txt` in sync with the blog posts in `_posts/`.

## Steps

1. **List all posts** using Glob on `_posts/*.md`, sorted by filename (which is date-prefixed).

2. **Find missing posts** by comparing filenames against URLs already listed in the `## Blog Posts` section of `llms.txt`. A post `_posts/YYYY-MM-DD-slug.md` corresponds to the URL `https://vivqu.com/blog/YYYY/MM/DD/slug/`.

3. **Read each missing post's frontmatter** (first ~15 lines) to get:
   - `title`: use as the link text
   - `subtitle`: helps inform the blurb
   - `seo_description`: use as a starting point for the blurb

4. **Write a short blurb** (one sentence, ~10–15 words) for each missing post. Base it on the title, subtitle, and any `seo_description`. If those aren't descriptive enough, read more of the post body.

5. **Insert missing entries into `llms.txt`** in reverse-chronological order (newest first) within the `## Blog Posts` section. Use this format:

   ```txt
   - [Title](https://vivqu.com/blog/YYYY/MM/DD/slug/): Blurb describing the post
   ```

   The permalink is derived from the filename: `_posts/YYYY-MM-DD-slug.md` → `/blog/YYYY/MM/DD/slug/`.

6. Confirm the final list is complete and in order.

## Notes

- Do not remove or rewrite existing entries — only add missing ones.
- Multi-part series posts should note their series and part number in the blurb.
- Match the tone and length of existing blurbs in the file.
