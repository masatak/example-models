data {
  int<lower=0> N;                // items
  int<lower=0> K;                // trials
  int<lower=0, upper=K> y[N];    // successes
}
parameters {
  real mu;                       // population mean of success log-odds
  real<lower=0> sigma;           // population sd of success log-odds
  vector[N] alpha;               // success log-odds
}
model {
  sigma ~ normal(0, 1);          // hyperprior
  mu ~ normal(-1, 2);            // hyperprior
  alpha ~ normal(mu, sigma);     // hierarchical prior
  y ~ binomial_logit(K, alpha);  // likelihood
}
generated quantities {
  vector<lower=0, upper=1>[N] theta;  // chance-of-success
  for (n in 1:N)
    theta[n] <- inv_logit(alpha[n]);
}
