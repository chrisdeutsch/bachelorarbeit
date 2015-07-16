import math

def trapz(x, y, dy):
    """ Integration nach Trapezregel mit Fehlerfortpflanzung """
    data = list(zip(x, y, dy))
    N = len(data)
    
    integral = 0
    std_dev = 0
    
    for i in range(N-1):
        integral += (x[i+1] - x[i]) * (y[i] + y[i+1])
    
    for i in range(1, N-1):
        std_dev += ((x[i+1] - x[i-1]) * dy[i])**2
    
    # Randpunkte
    std_dev += ((x[1] - x[0]) * dy[0])**2
    std_dev += ((x[N-1] - x[N-2]) * dy[N-1])**2
    
    integral *= 0.5
    std_dev = 0.5 * math.sqrt(std_dev)
    
    return integral, std_dev
