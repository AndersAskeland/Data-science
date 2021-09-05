### Assignment ###  

# Caching the Inverse of a Matrix Matrix inversion is usually a costly computation and there may be some benefit to caching the inverse 
# of a matrix rather than compute it repeatedly (there are also alternatives to matrix inversion that we will not discuss here). 
# My assignment is to write a pair of functions that cache the inverse of a matrix.

### Example ###


## This is a cache function, that basically makes a cache function for the input.
makeVector <- function(x = numeric()) {
    # Set m to NULL
    m <- NULL
    
    # 
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    
    # Define functions
    get <- function() {
        x
    }
    
    setmean <- function(mean) {
        m <<- mean
    }
    
    getmean <- function() {
        m
    }
    
    # Return a list with all the functions
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}

cachemean <- function(x, ...) {
    # Set m to input and getmean from the list function above?
    m <- x$getmean()
    
    # Checkjs if there is in fact data in x$getmean, and the function can return the data as is.
    if(!is.null(m)) {
        message("getting cached data")
        return(m) # Returns mean and exits function call.
    }
    
    # This runs if there is no cache.
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}
