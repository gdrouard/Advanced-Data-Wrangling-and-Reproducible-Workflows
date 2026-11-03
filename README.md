# Course ebook

My ebook for the course *Advanced Data Wrangling and Reproducible Workflows* (teached by Gabin Drouard), one chapter per part of the course.

## First-time setup

1. Click **Use this template** on GitHub to create your own repository, then clone it.
2. Open `ebook.Rproj` in RStudio.
3. Install the packages: `source("R/install_packages.R")`
4. Copy `.Renviron.example` to `.Renviron` and fill in your details
   (`usethis::edit_r_environ("project")` opens it).
5. Edit `_quarto.yml`: your name and your repository URL.
6. Check that it works: `quarto::quarto_render()` (or the **Render Book** button).
7. On GitHub: **Settings → Pages → Source: GitHub Actions**. Then push; your book
   is published after the workflow finishes.

## Rules

- Raw data go in `data/raw/` and are committed. Never edit them by hand.
- Chapters read only from saved files. They never call an API while rendering.
- Commit small and often. Pull before you push if you work on more than one machine.
