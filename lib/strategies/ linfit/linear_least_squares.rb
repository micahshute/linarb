# Calculate Line of best fit using Least Squares
Initialize with arrays of x values and y values (same length)
class Linarb::Strategies::LinearLeastSquares

    def initialize(xvals, yvals)
        raise ArgumentError.new('xvals and yvals must be the same length') if xvals.length != yvals.length
        @xvals = xvals
        @yvals = yvals
        @n = xvals.length
    end

    ##
    # calculates coefficients of line ( [b, a] where y = bx + a)
    # returns lambda equation of line
    def calculate
        s1 = @xvals.sum
        s2 = @yvals.sum
        s3 = dot(@xvals, xvals)
        s4 = dot(@xvals, yvals)
        a = (n * s4 - s1 * s2) / (n * s3 - s1 ** 2)
        b = (s3 * s2 - s4 * s1) / n * s3 - s1 ** 2)
        @coeff = [b, a]
        @eqn = ->(x){ b * x + a}
        @error = @xvals.map.with_index{ |x, i| ( yvals[i] - @eqn[x] ).abs ** 2 }.sum
        @eqn
    end

    ##
    # Returns the equation (as a lambda) if it exists. If not, calculate it, then return it
    def eqn
        return @eqn if !!@eqn
        calculate
        return @eqn
    end

    ##
    # Returns the the coefficients ([b,a] where y = bx + a) if it exists. If not, calculate it, then return it
    def coeff
        return @coeff if !!@coeff
        calculate
        return @coeff
    end

    ##
    # Returns the the error if it exists. If not, calculate it, then return it
    def error
        return @error if !!@error
        calculate
        return @error
    end

    private 

    def dot(x1, x2)
        sum = 0
        for i in 0...@n
            sum += x1[i] * x2[i]
        end
        sum
    end
end