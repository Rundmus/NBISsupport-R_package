# ------------------
#' Compare packages for parallel computing
#'
#' Surprisingly, performance of the packages for parallel computing differs
#' substantially. This requires a lot of those packages installed.
#'
#' @export
#'
#' @examples
#' compare_packages_for_parallel()
# ------------------

compare_packages_for_parallel <- function() {
  n_cores <- parallel::detectCores() - 1

  microbenchmark::microbenchmark(
    parallel = {
      cl <- parallel::makeCluster(n_cores)
      doParallel::registerDoParallel(cl)
      foreach(
        ii = iterators::icount(1000),
        .inorder = FALSE
      ) %dopar% {
        lm(Sepal.Length ~ Species, iris)
      }
      parallel::stopCluster(cl)
    },
    parallel2 = {
      doParallel::registerDoParallel(cores = n_cores)
      foreach(
        ii = iterators::icount(1000),
        .inorder = FALSE
      ) %dopar% {
        lm(Sepal.Length ~ Species, iris)
      }
    },
    doSNOW = {
      cl <- snow::makeCluster(n_cores)
      doSNOW::registerDoSNOW(cl)
      foreach(
        ii = iterators::icount(1000),
        .inorder = FALSE
      ) %dopar% {
        lm(Sepal.Length ~ Species, iris)
      }
      snow::stopCluster(cl)
    },
    doMC = {
      doMC::registerDoMC(n_cores)
      foreach(
        ii = iterators::icount(1000),
        .inorder = FALSE
      ) %dopar% {
        lm(Sepal.Length ~ Species, iris)
      }
    },
    times = 10L
  )
}
