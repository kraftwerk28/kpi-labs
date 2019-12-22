from scipy.stats import poisson
from scipy import mean


class StandardOutput:
    def __init__(self):
        self._counter = 0
        self._history = []

    def poissonize(self):
        if len(self._history) > 0:
            self._history.sort(key=lambda bid:
                               bid.processing_start - bid.advent)

            mu = mean([bid.processing_start - bid.advent
                       for bid in self._history])

            p = poisson.rvs(mu, size=len(self._history))
            p.sort()

            for i in range(len(self._history)):
                self._history[i]._start = self._history[i].advent + p[i]

            self._history.sort(key=lambda bid: bid._end)

    def echo(self, task):
        self._counter += 1
        self._history.append(task)

    def history(self):
        return self._history
