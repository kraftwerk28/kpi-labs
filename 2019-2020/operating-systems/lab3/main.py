import matplotlib.pyplot as plt
import numpy as np
import emulator.system as sys

# FIFO с приоритетами + вытеснением

system = sys.System(intensity=0.75, end_time=400)
system.run(True)

def init_plt():
    plt.figure()
    plt.tight_layout()
    plt.xkcd()

def proc_count():
    history, _ = system.statistics()
    x1 = [bid.processing_start - bid.advent for bid in history]

    plt.subplot(3, 1, 1)
    plt.xlabel('Wait time')
    plt.ylabel('Requests count')
    plt.hist(x1)
    plt.grid()

def wait_time():
    x2 = np.arange(0, 2, 0.1)
    def avg_delay(i):
        system = sys.System(i, 16, int(1000*(i + 0.1)))
        system.run()
        history_of_bids, _ = system.statistics()

        average_delay = 0
        if len(history_of_bids) > 0:
            delay_sum = 0
            for bid in history_of_bids:
                delay_sum += bid.processing_start - bid.advent

            average_delay = delay_sum / len(history_of_bids)
        return average_delay
    y2 = [avg_delay(i) for i in x2]

    plt.subplot(3, 1, 2)
    plt.xlabel('Intensity')
    plt.ylabel('Wait time')
    plt.plot(x2, y2)
    plt.grid()
    
def downtime():
    def st_time(i):
        system = sys.System(i, end_time=5000, max_complexity=5)
        system.run()
        _, standing_time = system.statistics()
        return standing_time
    x3 = np.arange(0.01, 1, 0.01)
    y3 = [st_time(i) for i in x3]

    plt.subplot(3, 1, 3)
    plt.xlabel('Intensity')
    plt.ylabel('Downtime')
    plt.plot(x3, y3)
    plt.grid()

if __name__ == '__main__':
    init_plt()
    proc_count()
    wait_time()
    downtime()
    plt.show()    
