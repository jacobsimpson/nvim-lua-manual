---
title:  "Graphing Gaussian Curves in Octave"
date:   2012-03-04 12:54:05
---

I've been working my way through Prof. Sebastian Thrun's second AI course, [CS
373 Programming a Robotic
Car](https://www.udacity.com/course/artificial-intelligence-for-robotics--cs373)
that he is offering through the new company,
[Udacity](https://www.udacity.com). In week two he covers Kalman filters as a
method of estimating location given uncertainty in sensor data and uncertainty
in movement.

In an effort to get a better understanding of how the variables affect the
shape of the Gaussian distribution that represents the probable state of the
variables being modelled, I fired up
[Octave](http://www.gnu.org/software/octave/). Octave is math software that
allows the user to do a large variety of things, but in my case I just wanted
to use it to graph a Gaussian distribution and see the effect of changing the
variables.

Thanks to
[this](http://zahidirfan.blogspot.com/2010/08/learning-probability-via-octave.html)
helpful, and to the point, post, it was reasonably straight forward to start
graphing curves in two dimensions.

```ruby
x = [1:0.1:6]
sigma = 5

mu = 10
fx = (1/sqrt(2*pi*sigma^2)*exp(-(x-mu).^2/(2*sigma^2)))
plot(x, fx)
```

This is enough to get started.

