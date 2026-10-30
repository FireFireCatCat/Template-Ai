"""Goodman-diagram fatigue check for the sensor-bracket bolt hole."""

# Cyclic load at the sensor mount [N]
F_MIN, F_MAX = 40.0, 260.0

# Bracket geometry [m] and root section properties
L = 0.18       # cantilever length
B, T = 0.030, 0.006  # cross-section width, thickness
D = 0.008      # bolt-hole diameter at the root section

# Material properties for 6061-T6 aluminium [Pa]
SIGMA_Y = 276e6       # yield stress
SIGMA_UTS = 310e6      # ultimate tensile stress
K_T = 2.1              # stress-concentration factor at the hole (from chart)


def bending_stress(force: float) -> float:
    """Nominal root bending stress for a given tip force."""
    net_width = B - D
    moment = force * L
    i_section = net_width * T ** 3 / 12
    c = T / 2
    return moment * c / i_section


def main() -> None:
    sigma_min = K_T * bending_stress(F_MIN)
    sigma_max = K_T * bending_stress(F_MAX)

    sigma_a = (sigma_max - sigma_min) / 2  # alternating stress
    sigma_m = (sigma_max + sigma_min) / 2  # mean stress

    # Goodman criterion: sigma_a / Se + sigma_m / Sut <= 1 is infinite life
    se_estimate = 0.5 * SIGMA_UTS  # rough endurance-limit estimate
    goodman = sigma_a / se_estimate + sigma_m / SIGMA_UTS

    print(f"peak local stress:  {sigma_max / 1e6:.1f} MPa")
    print(f"alternating stress: {sigma_a / 1e6:.1f} MPa")
    print(f"mean stress:        {sigma_m / 1e6:.1f} MPa")
    print(f"Goodman ratio:      {goodman:.2f} (<=1.0 required for infinite life)")


if __name__ == "__main__":
    main()
