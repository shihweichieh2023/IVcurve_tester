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

# Create figure with two y-axes
fig, ax1 = plt.subplots(figsize=(8, 6))
ax2 = ax1.twinx()

# Plot I-V curve
ax1.plot(V, I, 'b-', label='I-V Curve')
ax1.set_xlabel('Voltage (V)')
ax1.set_ylabel('Current (A)', color='b')
ax1.tick_params(axis='y', labelcolor='b')

# Plot power curve
ax2.plot(V, P, 'r-', label='Power')
ax2.set_ylabel('Power (W)', color='r')
ax2.tick_params(axis='y', labelcolor='r')

# Plot MPP point
ax2.plot(mpp_v, mpp_p, 'ro', label=f'MPP ({mpp_v:.2f}V, {mpp_p:.2f}W)')

# Add grid
ax1.grid(True)

# Add legends
lines1, labels1 = ax1.get_legend_handles_labels()
lines2, labels2 = ax2.get_legend_handles_labels()
ax1.legend(lines1 + lines2, labels1 + labels2, loc='upper right')

plt.title('Solar Cell I-V Curve and Power')

# Save plot
plt.savefig('images/IV_curve_example.png', dpi=300, bbox_inches='tight')
plt.close()
