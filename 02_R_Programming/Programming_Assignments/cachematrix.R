## Caching the inverse of a matrix: The following 2 functions are intended to 
##1) Create a matrix object that can cache its inverse and 
##2) Computes the inverse of a matrix returned by the first function. 
##If the inverse has already been calculated, the second function will retrieve 
##it from the cache. 

## Create matrix

makeCacheMatrix <- function(x = matrix()) {
  i <- NULL
  set <- function(y) {
    x <<- y
    i <<- NULL
  }
  get <- function() x
  setinv <- function(inv) i <<- inv
  getinv <- function() i
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)

}

## Solve for inverse of matrix created with first function, after checking if 
## it has been calculated and cached. 

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  i <- x$getinv()
  if(!is.null(i)) {
    message("getting cached data")
    return(i)
  }
  data <- x$get()
  i <- solve(data, ...)
  x$setinv(i)
  i
}
