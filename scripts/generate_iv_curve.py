import numpy as np
import matplotlib.pyplot as plt

# Generate voltage points
V = np.linspace(0, 1, 100)

# Generate current points (simplified solar cell equation)
I = 10 * (1 - np.exp((V - 1) / 0.025))

# Calculate power
P = V * I

# Find MPP
mpp_idx = np.argmax(P)
mpp_v = V[mpp_idx]
mpp_i = I[mpp_idx]
mpp_p = P[mpp_idx]

# Create plot
plt.figure(figsize=(8, 6))
plt.plot(V, I, 'b-', label='I-V Curve')
plt.plot([0, mpp_v], [I[0], mpp_i], 'r--', label='MPP Line')
plt.plot(mpp_v, mpp_i, 'ro', label=f'MPP ({mpp_v:.2f}V, {mpp_i:.2f}A)')

plt.grid(True)
plt.xlabel('Voltage (V)')
plt.ylabel('Current (A)')
plt.title('Solar Cell I-V Curve with Maximum Power Point')
plt.legend()

# Save plot
plt.savefig('images/IV_curve_example.png', dpi=300, bbox_inches='tight')
plt.close()
