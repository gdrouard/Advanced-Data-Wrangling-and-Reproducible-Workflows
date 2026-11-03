# Fetch-then-process helpers.
# Rule: a chapter NEVER calls an API while the book renders.
# You call the API once with fetch_cached(), commit the saved file in data/raw/,
# and the chapter reads only from that file.

#' Download a response once and save it to disk.
#'
#' @param url        Endpoint URL.
#' @param path       Where to save the raw response (e.g. data/raw/stats_2026-11-10.json).
#' @param query      Named list of query parameters.
#' @param refresh    TRUE to download again even if the file exists.
#' @param user_agent Who you are. Set COURSE_USER_AGENT in your .Renviron.
#' @return The file path (invisibly). A "<path>.meta.json" file records the
#'   URL, parameters and retrieval time, for your "Data source" box.
fetch_cached <- function(url, path, query = list(), refresh = FALSE,
                         user_agent = Sys.getenv("COURSE_USER_AGENT")) {
  if (file.exists(path) && !refresh) {
    message("Using existing file: ", path)
    return(invisible(path))
  }
  if (!nzchar(user_agent)) {
    stop("Set COURSE_USER_AGENT in your .Renviron (see .Renviron.example).",
         call. = FALSE)
  }

  resp <- httr2::request(url) |>
    httr2::req_url_query(!!!query) |>
    httr2::req_user_agent(user_agent) |>
    httr2::req_throttle(rate = 1) |>        # at most 1 request per second
    httr2::req_retry(max_tries = 3) |>
    httr2::req_perform()

  dir.create(dirname(path), recursive = TRUE, showWarnings = FALSE)
  writeLines(httr2::resp_body_string(resp), path, useBytes = TRUE)

  jsonlite::write_json(
    list(
      url       = url,
      query     = query,
      status    = httr2::resp_status(resp),
      retrieved = format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z")
    ),
    paste0(path, ".meta.json"),
    auto_unbox = TRUE, pretty = TRUE
  )

  message("Saved: ", path)
  invisible(path)
}
